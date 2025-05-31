variable "secret_name" {
  type        = string
  default     = "ecr-pull-secret"
  description = "The name of the Kubernetes secret"
}

variable "namespace" {
  type        = string
  default     = "default"
  description = "The Kubernetes namespace for the secret"
}

variable "ecr_registry" {
  type        = string
  description = "ECR registry URL (e.g., 123456789012.dkr.ecr.us-east-1.amazonaws.com)"
}
