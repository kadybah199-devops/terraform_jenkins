resource "aws_ebs_volume" "this" {
  availability_zone = var.availability_zone
  size              = var.ebs_size
  type              = var.ebs_type

  tags = {
    Name = var.ebs_name
  }
}