variable "project" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)  # ✅ Must be a list of 2+ subnets in different AZs
}

variable "asg_name" {
  type = string
}
