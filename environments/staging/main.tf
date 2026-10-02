terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = var.region
}
module "networking" {
  source          = "../../modules/networking"
  name            = var.name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
  tags            = var.tags
}
module "compute" {
  source               = "../../modules/compute"
  name                 = var.name
  vpc_id               = module.networking.vpc_id
  public_subnets       = module.networking.public_subnets
  private_subnets      = module.networking.private_subnets
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  asg_desired_capacity = var.asg_desired_capacity
  asg_min_size         = var.asg_min_size
  asg_max_size         = var.asg_max_size
  tags                 = var.tags
}
module "database" {
  source                  = "../../modules/database"
  name                    = var.name
  vpc_id                  = module.networking.vpc_id
  private_subnets         = module.networking.private_subnets
  app_security_group_id   = module.compute.app_security_group_id
  db_name                 = var.db_name
  db_username             = var.db_username
  db_password             = var.db_password
  db_instance_class       = var.db_instance_class
  allocated_storage       = var.allocated_storage
  engine_version          = var.engine_version
  backup_retention_period = var.backup_retention_period
  tags                    = var.tags
}
