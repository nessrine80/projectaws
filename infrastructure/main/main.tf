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
    owners      = var.business_division
    environment = var.environment
  }
  eks_cluster_name = "${local.name}-${var.cluster_name}"
}

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

module "security_group" {
  source              = "../modules/security-group"
  sg_name             = "${local.name}-public-bastion-sg"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  common_tags         = local.common_tags
}

module "ec2" {
  source             = "../modules/ec2"
  name               = local.name
  ami                = data.aws_ami.amzlinux2.id
  instance_type      = var.instance_type
  instance_keypair   = var.instance_keypair
  subnet_id          = module.vpc.public_subnets[0]
  security_group_ids = [module.security_group.security_group_id]
  common_tags        = local.common_tags
}

module "ecr" {
  source          = "../modules/ecr"
  repository_name = "llm-app"
  common_tags     = local.common_tags
}

module "eks" {
  source                           = "../modules/eks"
  name                             = local.name
  cluster_name                     = var.cluster_name
  cluster_service_ipv4_cidr       = var.cluster_service_ipv4_cidr
  cluster_version                  = var.cluster_version
  subnet_ids                       = module.vpc.public_subnets
  endpoint_private_access          = var.cluster_endpoint_private_access
  endpoint_public_access           = var.cluster_endpoint_public_access
  endpoint_public_access_cidrs     = var.cluster_endpoint_public_access_cidrs
  instance_keypair                 = var.instance_keypair
}

module "monitoring" {
  source           = "../modules/monitoring"
  kubeconfig_path  = "C:\\Users\\User\\.kube\\config"
  namespace        = "monitoring"
  chart_version    = "56.6.0"
}



module "llm_app" {
  source          = "../modules/llm_app"
  kubeconfig_path = "C:\\Users\\User\\.kube\\config"
  image_url       = "499845095635.dkr.ecr.us-east-1.amazonaws.com/llm-app:latest"
}
