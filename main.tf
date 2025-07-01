terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source               = "./modules/vpc"
  project              = var.project
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
}

module "sg" {
  source  = "./modules/security-groups"
  project = var.project
  vpc_id  = module.vpc.vpc_id
}

module "ec2" {
  source               = "./modules/ec2"
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  key_name             = var.key_name
  private_subnet_ids   = module.vpc.private_subnet_ids
  security_group_ids   = [module.sg.ec2_sg_id]
  min_size             = 1
  max_size             = 2
  desired_capacity     = 1
  project              = var.project
}

module "alb" {
  source            = "./modules/alb"
  project           = var.project
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  asg_name          = module.ec2.asg_name
  # Security group for ALB is created within the ALB module
}

module "rds" {
  source                = "./modules/rds"
  project               = var.project
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  ec2_security_group_id = module.sg.ec2_sg_id
  engine                = var.rds_engine
  engine_version        = var.rds_engine_version
  instance_class        = var.rds_instance_class
  username              = var.db_username
  password              = var.db_password
  port                  = var.rds_port
}
