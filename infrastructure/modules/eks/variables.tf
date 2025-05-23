variable "name" {
  description = "Prefix for naming resources"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_service_ipv4_cidr" {
  description = "Service CIDR block for EKS"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
}

variable "endpoint_private_access" {
  description = "Enable private endpoint for EKS"
  type        = bool
}

variable "endpoint_public_access" {
  description = "Enable public endpoint for EKS"
  type        = bool
}

variable "endpoint_public_access_cidrs" {
  description = "CIDR blocks for public access"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster and node group"
  type        = list(string)
}

variable "instance_keypair" {
  description = "SSH key pair for remote access"
  type        = string
}
