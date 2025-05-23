variable "aws_region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "environment" {
  default     = "stag"
  description = "Environment name"
}

variable "business_division" {
  default     = "hr"
  description = "Business unit"
}

variable "vpc_name" {
  default     = "myvpc"
  description = "Name of the VPC"
}

variable "vpc_cidr_block" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR block"
}

variable "vpc_public_subnets" {
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
  description = "Public subnets"
}

variable "vpc_private_subnets" {
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "Private subnets"
}

variable "vpc_database_subnets" {
  default     = ["10.0.151.0/24", "10.0.152.0/24"]
  description = "Database subnets"
}

variable "vpc_create_database_subnet_group" {
  default     = true
  type        = bool
  description = "Create DB subnet group"
}

variable "vpc_create_database_subnet_route_table" {
  default     = true
  type        = bool
  description = "Create DB subnet RT"
}

variable "vpc_enable_nat_gateway" {
  default     = true
  type        = bool
  description = "Enable NAT Gateway"
}

variable "vpc_single_nat_gateway" {
  default     = true
  type        = bool
  description = "Use single NAT"
}

variable "instance_type" {
  default     = "t3.micro"
  description = "EC2 instance type"
}

variable "instance_keypair" {
  default     = "llm"
  description = "SSH key pair"
}

variable "cluster_name" {
  default     = "eksdemo1"
  description = "EKS cluster name"
}

variable "cluster_service_ipv4_cidr" {
  default     = "172.20.0.0/16"
  description = "Kubernetes service CIDR"
}

variable "cluster_version" {
  default     = "1.26"
  description = "Kubernetes version"
}

variable "cluster_endpoint_private_access" {
  default     = false
  type        = bool
}

variable "cluster_endpoint_public_access" {
  default     = true
  type        = bool
}

variable "cluster_endpoint_public_access_cidrs" {
  default     = ["0.0.0.0/0"]
  type        = list(string)
}
