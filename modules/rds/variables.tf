variable "project" {
  description = "Project name prefix"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "ec2_security_group_id" {
  description = "EC2 security group that needs access to RDS"
  type        = string
}



variable "engine_version" {
  description = "Engine version"
  type        = string
}

variable "instance_class" {
  description = "Instance type"
  type        = string
}

variable "username" {
  description = "Master DB username"
  type        = string
}

variable "password" {
  description = "Master DB password"
  type        = string
  sensitive   = true
}

variable "engine" {
  description = "RDS engine (e.g., mysql or postgres)"
  type        = string
  default     = "mysql"
}

variable "port" {
  description = "Port number"
  type        = number
  default     = 3306
}
