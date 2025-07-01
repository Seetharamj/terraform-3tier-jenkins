resource "aws_launch_template" "app" {
  name_prefix   = "${var.project}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  key_name = var.key_name

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.security_group_id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project}-app-instance"
    }
  }
}

resource "aws_autoscaling_group" "app_asg" {
  name                      = "${var.project}-asg"
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  vpc_zone_identifier       = var.private_subnet_ids
  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
  health_check_type         = "EC2"
  health_check_grace_period = 300
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "${var.project}-app-instance"
    propagate_at_launch = true
  }
}
