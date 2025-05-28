variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}


variable "kubeconfig_path" {
  description = "Path to kubeconfig to access the Kubernetes cluster"
  type        = string
  default     = "C:\\Users\\User\\.kube\\config"
}


variable "environment" {
  description = "Environment name (e.g., dev, stag, prod)"
  type        = string
  default     = "stag"
}

variable "business_division" {
  description = "Business division or team"
  type        = string
  default     = "hr"
}

# VPC
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "myvpc"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "vpc_private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_database_subnets" {
  description = "List of database subnet CIDRs"
  type        = list(string)
  default     = ["10.0.151.0/24", "10.0.152.0/24"]
}

variable "vpc_create_database_subnet_group" {
  description = "Whether to create DB subnet group"
  type        = bool
  default     = true
}

variable "vpc_create_database_subnet_route_table" {
  description = "Whether to create DB subnet route table"
  type        = bool
  default     = true
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway"
  type        = bool
  default     = true
}

variable "vpc_single_nat_gateway" {
  description = "Use a single NAT gateway for cost efficiency"
  type        = bool
  default     = true
}

# EKS
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "MyCluster"
}

variable "cluster_service_ipv4_cidr" {
  description = "Kubernetes service CIDR block"
  type        = string
  default     = "172.20.0.0/16"
}

variable "cluster_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.26"
}

variable "cluster_endpoint_private_access" {
  description = "Enable private endpoint access for the cluster"
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access" {
  description = "Enable public endpoint access for the cluster"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDRs allowed to access the public endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# EC2
variable "instance_type" {
  description = "Type of the EC2 instance for bastion"
  type        = string
  default     = "t3.micro"
}

variable "instance_keypair" {
  description = "SSH key pair for EC2 and EKS nodes"
  type        = string
  default     = "llm"
}
