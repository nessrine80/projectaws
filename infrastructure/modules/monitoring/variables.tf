variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "C:\\Users\\User\\.kube\\config"
}

variable "namespace" {
  description = "Namespace where monitoring stack will be deployed"
  type        = string
  default     = "monitoring"
}

variable "chart_version" {
  description = "Version of kube-prometheus-stack Helm chart"
  type        = string
  default     = "56.6.0"
}
