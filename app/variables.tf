variable "aws_region" {
  description = "Région AWS où déployer les ressources"
  type        = string
  default     = "us-east-1"
}

variable "availability_zone" {
  description = "Zone de disponibilité pour l'instance EC2"
  type        = string
  default     = "us-east-1a"
}

variable "instance_type" {
  description = "Type d'instance EC2 pour Jenkins"
  type        = string
  default     = "t2.medium"
}

variable "instance_tag" {
  description = "Tag Name de l'instance EC2"
  type        = string
  default     = "jenkins-server"
}

variable "ebs_size" {
  description = "Taille du volume EBS en Go"
  type        = number
  default     = 20
}

variable "ebs_type" {
  description = "Type du volume EBS (gp2, gp3, io1...)"
  type        = string
  default     = "gp2"
}

variable "ebs_name" {
  description = "Tag Name du volume EBS"
  type        = string
  default     = "jenkins-data"
}

variable "eip_name" {
  description = "Tag Name de l'Elastic IP"
  type        = string
  default     = "jenkins-eip"
}

variable "sg_name" {
  description = "Nom du Security Group"
  type        = string
  default     = "jenkins-sg"
}

variable "key_name" {
  description = "Nom de la paire de clés SSH"
  type        = string
  default     = "jenkins-key"
}