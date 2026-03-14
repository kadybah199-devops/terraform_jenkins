variable "availability_zone" {
  description = "Zone de disponibilité du volume EBS"
  type        = string
}

variable "ebs_size" {
  description = "Taille du volume en Go"
  type        = number
  default     = 20
}

variable "ebs_type" {
  description = "Type du volume EBS "
  type        = string
  default     = "gp2"
}

variable "ebs_name" {
  description = "Tag Name du volume EBS"
  type        = string
  default     = "jenkins-ebs"
}