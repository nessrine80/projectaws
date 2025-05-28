output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of private subnets"
  value       = module.vpc.private_subnets
}

output "nat_public_ips" {
  description = "List of public Elastic IPs for NAT"
  value       = module.vpc.nat_public_ips
}

output "azs" {
  description = "Availability zones used"
  value       = module.vpc.azs
}

output "vpc_cidr_block" {
  description = "VPC CIDR block"
  value       = module.vpc.vpc_cidr_block
}
