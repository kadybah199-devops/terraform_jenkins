output "eip_id" {
  description = "Allocation ID de l'Elastic IP"
  value       = aws_eip.this.id
}

output "public_ip" {
  description = "Adresse IP publique"
  value       = aws_eip.this.public_ip
}

output "public_dns" {
  description = "DNS public associé à l'EIP"
  value       = aws_eip.this.public_dns
}