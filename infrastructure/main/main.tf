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

# Zones de disponibilité
data "aws_availability_zones" "available" {}

# AMI Amazon Linux 2 pour EC2 Bastion
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
    owner       = var.business_division
  }
  eks_cluster_name = "${local.name}-${var.cluster_name}"
}

# --- VPC ---
module "vpc" {
  source = "../modules/vpc"

  vpc_name                               = var.vpc_name
  vpc_cidr_block                         = var.vpc_cidr_block
  vpc_public_subnets                     = var.vpc_public_subnets
  vpc_private_subnets                    = var.vpc_private_subnets
  vpc_database_subnets                   = var.vpc_database_subnets
  vpc_create_database_subnet_group       = var.vpc_create_database_subnet_group
  vpc_create_database_subnet_route_table = var.vpc_create_database_subnet_route_table
  vpc_enable_nat_gateway                 = var.vpc_enable_nat_gateway
  vpc_single_nat_gateway                 = var.vpc_single_nat_gateway
  eks_cluster_name                       = local.eks_cluster_name
  common_tags                            = local.common_tags
}



# --- Security Group Bastion ---
module "public_bastion_sg" {
  source              = "../modules/security_group"
  name                = "${local.name}-public-bastion-sg"
  description         = "Allow SSH access from anywhere"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]
  tags                = local.common_tags
}

# --- Bastion EC2 ---
module "ec2_bastion" {
  source                 = "../modules/ec2_bastion"
  name                   = "${local.name}-bastion"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  tags                   = local.common_tags
}

# --- EKS ---
module "eks" {
  source = "../modules/eks"

  cluster_name                          = var.cluster_name
  cluster_version                       = var.cluster_version
  cluster_service_ipv4_cidr            = var.cluster_service_ipv4_cidr
  cluster_endpoint_private_access      = var.cluster_endpoint_private_access
  cluster_endpoint_public_access       = var.cluster_endpoint_public_access
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs

  subnet_ids        = module.vpc.private_subnets
  instance_type     = var.instance_type
  key_name          = var.instance_keypair
  node_group_name   = "default-node-group"
  eks_master_role_name = "eks-master-role"
  eks_node_role_name   = "eks-nodegroup-role"

  name_prefix = local.name
  tags        = local.common_tags
}

# --- ECR ---
module "ecr" {
  source = "../modules/ecr"
  name   = "mon-app"
  tags   = local.common_tags
}
