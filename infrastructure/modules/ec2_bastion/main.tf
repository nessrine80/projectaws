module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.0.0"

  name                   = var.name
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  tags                   = var.tags
}

resource "aws_eip" "bastion_eip" {
  instance = module.ec2_instance.id
  vpc      = true
  tags     = var.tags
}

