output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = ["${module.ec2.private_ip}"]
}

output "public_ip" {
  description = "List of public IP addresses assigned to the instances"
  value       = ["${module.ec2.public_ip}"]
}
