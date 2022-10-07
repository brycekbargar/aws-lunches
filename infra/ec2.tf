data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "tls_private_key" "web_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

output "web_private_key" {
  value     = tls_private_key.web_key.private_key_pem
  sensitive = true
}

resource "aws_key_pair" "web_key" {
  key_name   = "web_key"
  public_key = tls_private_key.web_key.public_key_openssh
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  key_name = aws_key_pair.web_key.key_name
}
