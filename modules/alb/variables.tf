variable "project" {
  description = "Prefix for resource names"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ALB and SG will be created"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for ALB"
  type        = list(string)
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group to attach to the Target Group"
  type        = string
}
