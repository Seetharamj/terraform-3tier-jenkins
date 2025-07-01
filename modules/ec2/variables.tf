variable "project" {
  description = "Project name prefix"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

# Keep only one declaration (remove the duplicate)
variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "key_name" {
  description = "EC2 Key pair name"
  type        = string
}

variable "min_size" {
  type = number
}
variable "max_size" {
  type = number
}
variable "desired_capacity" {
  type = number
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID to associate with EC2 instances"
  type        = string
}
