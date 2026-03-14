data "aws_ami" "ubuntu_jammy" {
  most_recent = true
  owners      = ["099720109477"] 
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "this" {
  ami                    = data.aws_ami.ubuntu_jammy.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.sg_id]
  availability_zone      = var.availability_zone
  user_data              = var.user_data

  root_block_device {
    volume_size           = 20
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name = var.instance_tag
  }
}

resource "aws_volume_attachment" "this" {
  device_name  = "/dev/sdf"
  volume_id    = var.ebs_id
  instance_id  = aws_instance.this.id
  force_detach = true
}

resource "aws_eip_association" "this" {
  instance_id   = aws_instance.this.id
  allocation_id = var.eip_id
}