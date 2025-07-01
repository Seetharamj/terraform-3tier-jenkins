variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

variable "rds_engine" {
  description = "Database engine for RDS"
  type        = string
}

variable "rds_engine_version" {
  description = "Engine version for RDS"
  type        = string
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "rds_port" {
  description = "Port number for RDS"
  type        = number
}
