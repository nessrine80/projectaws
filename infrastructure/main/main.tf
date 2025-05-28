terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Get all availability zones
data "aws_availability_zones" "available" {}

# Get latest Amazon Linux 2 AMI for ec2_bastion module
data "aws_ami" "amzlinux2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

locals {
  name        = "${var.business_division}-${var.environment}"
  common_tags = {
    environment = var.environment
    owners      = var.business_division
  }
  eks_cluster_name = "${local.name}-${var.cluster_name}"
}

# VPC module
module "vpc" {
  source = "../modules/vpc"

  vpc_name                                = var.vpc_name
  vpc_cidr_block                          = var.vpc_cidr_block
  vpc_public_subnets                      = var.vpc_public_subnets
  vpc_private_subnets                     = var.vpc_private_subnets
  vpc_database_subnets                    = var.vpc_database_subnets
  vpc_create_database_subnet_group        = var.vpc_create_database_subnet_group
  vpc_create_database_subnet_route_table  = var.vpc_create_database_subnet_route_table
  vpc_enable_nat_gateway                  = var.vpc_enable_nat_gateway
  vpc_single_nat_gateway                  = var.vpc_single_nat_gateway

  azs                = data.aws_availability_zones.available.names
  tags               = local.common_tags
  eks_cluster_name   = local.eks_cluster_name
}

# Security group for bastion host
module "public_bastion_sg" {
  source              = "../modules/security_group"
  name                = "${local.name}-public-bastion-sg"
  description         = "Allow SSH access from anywhere"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]
  tags                = local.common_tags
}

# EC2 bastion host
module "ec2_bastion" {
  source                 = "../modules/ec2_bastion"
  name                   = "${local.name}-BastionHost"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  tags                   = local.common_tags
}

module "eks" {
  source = "../modules/eks"

  cluster_name                          = "Mycluster"
  cluster_version                       = "1.29"
  cluster_service_ipv4_cidr            = "172.20.0.0/16"
  cluster_endpoint_private_access      = false
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

  subnet_ids      = module.vpc.private_subnets
  instance_type   = "t3.medium"
  key_name        = "llm"
  node_group_name = "default-node-group"

  eks_master_role_name = "eks-master-role"
  eks_node_role_name   = "eks-nodegroup-role"

  name_prefix = local.name
  tags        = local.common_tags
}


# ECR image repo
module "ecr" {
  source = "../modules/ecr"
  name   = "llm-app"
  tags   = local.common_tags
}
