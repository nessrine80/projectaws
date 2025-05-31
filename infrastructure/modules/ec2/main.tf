module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.0.0"

  name                        = "${var.name}-BastionHost"
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.instance_keypair
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  tags                        = var.common_tags
}

resource "aws_eip" "bastion_eip" {
  depends_on = [module.ec2_instance]
  instance   = module.ec2_instance.id
  vpc        = true
  tags       = var.common_tags
}
