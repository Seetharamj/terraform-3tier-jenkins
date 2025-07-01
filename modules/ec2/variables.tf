variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

variable "instance_type" {
  default     = "t2.micro"
  description = "EC2 instance type"
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs"
}

variable "security_group_id" {
  description = "Security group ID for EC2"
  type        = string
}

variable "min_size" {
  default = 1
}

variable "max_size" {
  default = 2
}

variable "desired_capacity" {
  default = 1
}

variable "project" {
  description = "Project name"
  type        = string
}
