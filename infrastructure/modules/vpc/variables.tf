variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "vpc_private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "vpc_database_subnets" {
  description = "List of database subnet CIDRs"
  type        = list(string)
}

variable "vpc_create_database_subnet_group" {
  description = "Whether to create a database subnet group"
  type        = bool
}

variable "vpc_create_database_subnet_route_table" {
  description = "Whether to create a route table for DB subnets"
  type        = bool
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for outbound internet"
  type        = bool
}

variable "vpc_single_nat_gateway" {
  description = "Use a single NAT gateway for cost savings"
  type        = bool
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "tags" {
  description = "Common tags for resources"
  type        = map(string)
}

variable "eks_cluster_name" {
  description = "Used to tag subnets for EKS integration"
  type        = string
}
