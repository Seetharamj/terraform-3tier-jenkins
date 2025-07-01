output "asg_name" {
  description = "The name of the Auto Scaling Group"
  value       = aws_autoscaling_group.app_asg.name
}

output "ec2_sg_id" {
  description = "Security Group ID for EC2 instances"
  value       = aws_security_group.app_sg.id
}
