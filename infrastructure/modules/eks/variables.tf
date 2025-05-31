variable "name" {
  description = "Prefix for resource names"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
}

variable "cluster_service_ipv4_cidr" {
  description = "Service CIDR for EKS"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for EKS and node group"
  type        = list(string)
}

variable "endpoint_private_access" {
  type        = bool
  default     = false
}

variable "endpoint_public_access" {
  type        = bool
  default     = true
}

variable "endpoint_public_access_cidrs" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "instance_keypair" {
  description = "SSH key pair name"
  type        = string
}
