# DELETE THIS ENTIRE RESOURCE BLOCK
resource "aws_security_group" "app_sg" {
  name        = "${var.project}-app-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-app-sg"
  }
}
resource "aws_autoscaling_group" "app_asg" {
  name                = "${var.project}-asg"
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.private_subnet_ids
  
  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
}
resource "aws_launch_template" "app" {
  name_prefix   = "${var.project}-lt"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  
  network_interfaces {
    security_groups = [var.security_group_id]
  }
  
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project}-app-instance"
    }
  }
}
