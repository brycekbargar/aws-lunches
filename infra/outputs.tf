output "web_private_key" {
  description = "Private key contents in pem format used to ssh into the web server"
  value       = tls_private_key.web_key.private_key_pem
  sensitive   = true
}

output "web_public_dns" {
  description = "Public DNS name assigned to web server."
  value       = aws_instance.web.public_dns
}
