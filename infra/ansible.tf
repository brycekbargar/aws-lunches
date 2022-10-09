locals {
  web_key_pem = pathexpand("~/.ssh/${random_pet.web_key_name.id}.pem")
}

resource "local_sensitive_file" "web_key" {
  filename             = local.web_key_pem
  directory_permission = "0700"
  file_permission      = "0400"
  content              = tls_private_key.web_key.private_key_pem
}

resource "local_file" "inventory" {
  filename             = "${path.root}/../playbooks/terraform.yaml"
  directory_permission = "0755"
  file_permission      = "0644"
  content              = <<INVENTORY
terraform:
  hosts:
    web_server:
      ansible_host: ${aws_instance.web.public_dns}
      ansible_user: ubuntu
      ansible_ssh_private_key_file: ${local.web_key_pem}
      wordpress_db_username: ${aws_db_instance.wordpress.username}
      wordpress_db_password: ${random_password.wordpress.result}
      wordpress_db_host: ${aws_db_instance.wordpress.address}
      wordpress_db_name: ${aws_db_instance.wordpress.db_name}
INVENTORY
}
