variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the SG is created"
  type        = string
}

variable "ingress_ports" {
  description = "List of TCP ingress ports to allow"
  type        = list(number)
  default     = [22]
}

variable "ingress_rules" {
  description = "Named ingress rule types (e.g. ssh-tcp)"
  type        = list(string)
  default     = []
}

variable "ingress_cidr_blocks" {
  description = "CIDRs allowed for ingress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "egress_rules" {
  description = "Named egress rule types"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags for the security group"
  type        = map(string)
  default     = {}
}
