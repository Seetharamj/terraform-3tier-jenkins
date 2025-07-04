terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.30"  # stable, safe version
    }
  }

  required_version = ">= 1.4.0"
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
  source      = "./modules/security-groups"
  vpc_id      = module.vpc.vpc_id
  environment = var.environment
  project     = var.project
}


module "ec2" {
  source             = "./modules/ec2"
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  key_name             = var.key_name
  private_subnet_ids   = module.vpc.private_subnet_ids
  min_size          = var.min_size
  max_size          = var.max_size
  desired_capacity  = var.desired_capacity
  project              = var.project
  vpc_id               = module.vpc.vpc_id  # This is the missing argument
  security_group_id    = module.sg.ec2_sg_id
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
