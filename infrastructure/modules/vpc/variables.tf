variable "vpc_name" {
  description = "VPC Name"
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
  description = "Whether to create DB subnet group"
  type        = bool
}

variable "vpc_create_database_subnet_route_table" {
  description = "Whether to create DB subnet route table"
  type        = bool
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT Gateway"
  type        = bool
}

variable "vpc_single_nat_gateway" {
  description = "Use single NAT Gateway"
  type        = bool
}

variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)
}

variable "eks_cluster_name" {
  description = "EKS cluster name (used in subnet tags)"
  type        = string
}
