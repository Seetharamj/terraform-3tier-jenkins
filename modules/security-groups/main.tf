

resource "aws_security_group" "app_sg" {
  name        = "my-3tier-app-app-sg-${var.environment}"
  description = "App tier security group"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP"
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
    Name        = "app-sg-${var.environment}"
    Environment = var.environment
  }
}
