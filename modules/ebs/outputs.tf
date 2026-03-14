output "ebs_id" {
  description = "ID du volume EBS"
  value       = aws_ebs_volume.this.id
}