variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}


variable "key_name" {
  description = "EC2 Key Pair"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID where EC2 will be deployed"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
}

variable "min_size" {
  default     = 1
  description = "Minimum number of instances"
}

variable "max_size" {
  default     = 2
  description = "Maximum number of instances"
}

variable "desired_capacity" {
  default     = 1
  description = "Desired number of instances"
}

variable "project" {
  description = "Project name"
  type        = string
}
