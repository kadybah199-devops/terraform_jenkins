terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws   = { source = "hashicorp/aws",   version = "~> 5.0" }
    tls   = { source = "hashicorp/tls",   version = "~> 4.0" }
    local = { source = "hashicorp/local", version = "~> 2.0" }
  }
}

provider "aws" {
  region = var.aws_region
}

module "security_group" {
  source  = "../modules/security_group"
  sg_name = var.sg_name
}

module "key_pair" {
  source   = "../modules/key_pair"
  key_name = var.key_name
}

module "ebs" {
  source            = "../modules/ebs"
  availability_zone = var.availability_zone
  ebs_size          = var.ebs_size
  ebs_type          = var.ebs_type
  ebs_name          = var.ebs_name
}

module "eip" {
  source   = "../modules/eip"
  eip_name = var.eip_name
}

module "ec2" {
  source            = "../modules/ec2"
  instance_type     = var.instance_type
  instance_tag      = var.instance_tag
  availability_zone = var.availability_zone
  key_name          = module.key_pair.key_name
  sg_id             = module.security_group.sg_id
  ebs_id            = module.ebs.ebs_id
  eip_id            = module.eip.eip_id
  user_data         = file("${path.module}/user_data.sh")
}

resource "local_file" "jenkins_info" {
  content  = <<-EOT
    ===== Jenkins Server Information =====
    Public IP  : ${module.eip.public_ip}
    Public DNS : ${module.eip.public_dns}
    Jenkins URL: http://${module.eip.public_ip}:8080
    =======================================
  EOT
  filename = "${path.module}/jenkins_ec2.txt"
}