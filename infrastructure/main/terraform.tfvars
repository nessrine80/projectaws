aws_region       = "us-east-1"
environment      = "stag"
business_division = "hr"

vpc_name                               = "myvpc"
vpc_cidr_block                         = "10.0.0.0/16"
vpc_public_subnets                     = ["10.0.101.0/24", "10.0.102.0/24"]
vpc_private_subnets                    = ["10.0.1.0/24", "10.0.2.0/24"]
vpc_database_subnets                   = ["10.0.151.0/24", "10.0.152.0/24"]
vpc_create_database_subnet_group       = true
vpc_create_database_subnet_route_table = true
vpc_enable_nat_gateway                 = true
vpc_single_nat_gateway                 = true

instance_type    = "t3.micro"
instance_keypair = "llm"

cluster_name                         = "eksdemo1"
cluster_service_ipv4_cidr            = "172.20.0.0/16"
cluster_version                      = "1.26"
cluster_endpoint_private_access      = false
cluster_endpoint_public_access       = true
cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
