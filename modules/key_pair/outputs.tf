output "key_name" {
  description = "Nom de la key pair créée"
  value       = aws_key_pair.this.key_name
}

output "private_key_pem" {
  description = "Clé privée "
  value       = tls_private_key.this.private_key_pem
  sensitive   = true
}