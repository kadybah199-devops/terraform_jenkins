variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
  default     = "t2.medium"
}

variable "instance_tag" {
  description = "Tag Name de l'instance EC2"
  type        = string
  default     = "jenkins-server"
}

variable "availability_zone" {
  description = "Zone de disponibilité pour l'instance EC2"
  type        = string
}

variable "key_name" {
  description = "Nom de la paire de clés SSH à attacher"
  type        = string
}

variable "sg_id" {
  description = "ID du security group à attacher"
  type        = string
}

variable "ebs_id" {
  description = "ID du volume EBS à attacher"
  type        = string
}

variable "eip_id" {
  description = "Allocation ID de l'Elastic IP à associer"
  type        = string
}

variable "user_data" {
  description = "Script user_data exécuté au démarrage"
  type        = string
  default     = ""
}