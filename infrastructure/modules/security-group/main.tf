module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.2"

  name        = var.sg_name
  description = "Public Bastion Host Security Group with SSH open"
  vpc_id      = var.vpc_id

  ingress_rules       = ["ssh-tcp"]
  ingress_cidr_blocks = var.ingress_cidr_blocks

  egress_rules = ["all-all"]

  tags = var.common_tags
}
