variable "region" {
  description = "AWS Region"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Key pair name for EC2 instance"
  type        = string
}

variable "rds_engine" {
  description = "RDS database engine"
  type        = string
}

variable "rds_engine_version" {
  description = "RDS engine version"
  type        = string
}

variable "rds_instance_class" {
  description = "Instance class for RDS"
  type        = string
}

variable "rds_port" {
  description = "Port for RDS database"
  type        = number
}
