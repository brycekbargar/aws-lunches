resource "tls_private_key" "web_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "random_pet" "web_key_name" {
  keepers = {
    key_value = tls_private_key.web_key.public_key_fingerprint_md5
  }
}

resource "aws_key_pair" "web_key" {
  key_name   = random_pet.web_key_name.id
  public_key = tls_private_key.web_key.public_key_openssh
}
