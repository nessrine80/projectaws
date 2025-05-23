variable "sg_name" {
  description = "Name of the security group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the SG will be created"
  type        = string
}

variable "ingress_cidr_blocks" {
  description = "List of CIDR blocks allowed to SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "common_tags" {
  description = "Tags to apply to the SG"
  type        = map(string)
}
