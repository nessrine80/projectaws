output "instance_id" {
  description = "ID of the Bastion EC2 instance"
  value       = module.ec2_instance.id
}

output "public_ip" {
  description = "Elastic IP of the Bastion EC2 instance"
  value       = aws_eip.bastion_eip.public_ip
}

output "elastic_ip" {
  description = "Elastic IP of the bastion instance"
  value       = aws_eip.bastion_eip.public_ip
}


