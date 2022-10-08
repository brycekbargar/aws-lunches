locals {
  web_key_pem = pathexpand("~/.ssh/${random_pet.web_key_name.id}.pem")
}

resource "local_sensitive_file" "web_key" {
  filename             = local.web_key_pem
  directory_permission = "0700"
  file_permission      = "0400"
  content              = tls_private_key.web_key.private_key_pem
}

resource "random_password" "web" {
  count   = 2
  length  = 31
  special = true
  keepers = {
    key_value = aws_instance.hello_world_web.arn
  }
}

resource "local_file" "inventory" {
  filename             = "${path.root}/../playbooks/terraform.yaml"
  directory_permission = "0755"
  file_permission      = "0644"
  content              = <<INVENTORY
terraform:
  hosts:
    web_server:
      ansible_host: ${aws_instance.hello_world_web.public_dns}
      ansible_user: ubuntu
      ansible_ssh_private_key_file: ${local.web_key_pem}
      mysql_root_password: ${random_password.web[0].result}
      wordpress_db_password: ${random_password.web[1].result}
INVENTORY
}
