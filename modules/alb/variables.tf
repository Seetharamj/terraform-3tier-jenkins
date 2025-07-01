variable "project" {
  description = "Project name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs across 2 AZs"
  type        = list(string)
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}
