output "ec2_sg_id" {
  description = "ID of the EC2 Security Group"
  value       = aws_security_group.app_sg.id
}
