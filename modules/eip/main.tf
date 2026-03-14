resource "aws_eip" "this" {
  domain = "vpc"

  tags = {
    Name = var.eip_name
  }
}