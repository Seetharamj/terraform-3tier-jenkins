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

variable "engine" {
  description = "RDS engine (e.g., mysql or postgres)"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Engine version"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "Instance type"
  type        = string
  default     = "db.t3.micro"
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

variable "port" {
  description = "Port number (3306 for MySQL, 5432 for PostgreSQL)"
  type        = number
  default     = 3306
}
