variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the cluster"
  type        = string
}

variable "cluster_service_ipv4_cidr" {
  description = "CIDR block for Kubernetes service IPs"
  type        = string
  default     = null
}

variable "cluster_endpoint_private_access" {
  description = "Whether the EKS private API server endpoint is enabled"
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access" {
  description = "Whether the EKS public API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks allowed to access EKS public API"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "instance_type" {
  description = "Instance type for EKS worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "Name of the EC2 key pair for SSH access"
  type        = string
}

variable "node_group_name" {
  description = "Name of the node group"
  type        = string
  default     = "default-node-group"
}

variable "eks_master_role_name" {
  description = "IAM role name for EKS control plane"
  type        = string
  default     = "eks-master-role"
}

variable "eks_node_role_name" {
  description = "IAM role name for EKS worker nodes"
  type        = string
  default     = "eks-nodegroup-role"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "name_prefix" {
  description = "Prefix for resource naming"
  type        = string
}
