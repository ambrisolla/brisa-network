vpc_cidr             = "20.0.0.0/16"
vpc_name             = "brisa"
project_name         = "brisa-stack"
environment          = "stg"
azs                  = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnet_cidrs  = ["20.0.1.0/24", "20.0.2.0/24", "20.0.3.0/24"]
private_subnet_cidrs = ["20.0.101.0/24", "20.0.102.0/24", "20.0.103.0/24"]
enable_nat_gateway   = false