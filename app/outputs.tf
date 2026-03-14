output "jenkins_url" {
  value = "http://${module.eip.public_ip}:8080"
}

output "ssh_connection" {
  value = "ssh -i ${var.key_name}.pem ubuntu@${module.eip.public_ip}"
}