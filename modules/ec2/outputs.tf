output "instance_id" {
  description = "ID de l'instance EC2"
  value       = aws_instance.this.id
}

output "instance_public_ip" {
  description = "IP publique de l'instance"
  value       = aws_instance.this.public_ip
}

output "ami_id" {
  description = "AMI Ubuntu Jammy utilisée"
  value       = data.aws_ami.ubuntu_jammy.id
}