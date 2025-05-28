# VPC Outputs
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "vpc_public_subnets" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

output "vpc_private_subnets" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}

output "vpc_nat_public_ips" {
  description = "List of NAT Gateway Elastic IPs"
  value       = module.vpc.nat_public_ips
}

# EC2 Bastion Outputs
output "bastion_instance_id" {
  description = "ID of the Bastion EC2 instance"
  value       = module.ec2_bastion.instance_id
}

output "bastion_public_ip" {
  description = "Elastic IP address of the Bastion Host"
  value       = module.ec2_bastion.elastic_ip
}

# Security Group
output "bastion_security_group_id" {
  description = "ID of the Bastion Host security group"
  value       = module.public_bastion_sg.security_group_id
}

# EKS Cluster Outputs
output "eks_cluster_id" {
  description = "The EKS Cluster ID"
  value       = module.eks.cluster_id
}

output "eks_cluster_arn" {
  description = "The EKS Cluster ARN"
  value       = module.eks.cluster_arn
}

output "eks_cluster_endpoint" {
  description = "The Kubernetes API endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_ca" {
  description = "Base64 encoded CA cert for cluster communication"
  value       = module.eks.cluster_certificate_authority_data
}

output "eks_oidc_issuer_url" {
  description = "OIDC issuer URL for IAM roles for service accounts"
  value       = module.eks.cluster_oidc_issuer_url
}

output "eks_nodegroup_id" {
  description = "ID of the public EKS Node Group"
  value       = module.eks.node_group_public_id
}

# ECR Output
output "ecr_repository_url" {
  description = "URL of the created ECR repository"
  value       = module.ecr.repository_url
}
