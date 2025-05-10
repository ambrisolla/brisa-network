provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source               = "../../modules/vpc"
  vpc_cidr             = var.vpc_cidr
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
  azs                  = var.azs
  environment          = var.environment
  project_name         = var.project_name
  vpc_name             = var.vpc_name
}
