output "ec2_sg_id" {
  description = "Security Group ID for EC2 instances"
  value       = aws_security_group.app_sg.id
}
