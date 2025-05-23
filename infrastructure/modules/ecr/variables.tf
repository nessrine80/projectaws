variable "repository_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "common_tags" {
  description = "Tags to apply to the ECR repository"
  type        = map(string)
}


