output "ec2_instance_id" {
  description = "The ID of the EC2 instance"
  value       = module.ec2_instance.id
}

output "bastion_eip" {
  description = "The public Elastic IP assigned to the instance"
  value       = aws_eip.bastion_eip.public_ip
}
