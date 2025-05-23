variable "ami" {
  description = "AMI ID to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "instance_keypair" {
  description = "Key pair name to associate with the EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to launch the EC2 instance in"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the EC2 instance"
  type        = list(string)
}

variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)
}

variable "name" {
  description = "Prefix for naming resources"
  type        = string
}
