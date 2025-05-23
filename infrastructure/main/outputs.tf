output "vpc_id" {
  value = module.vpc.vpc_id
}

output "bastion_ip" {
  value = module.ec2.bastion_eip
}

output "eks_endpoint" {
  value = module.eks.cluster_endpoint
}

output "ecr_repo_url" {
  value = module.ecr.repository_url
}
