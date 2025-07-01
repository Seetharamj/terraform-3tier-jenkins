resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.project}-rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project}-rds-subnet-group"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.project}-rds-sg"
  description = "Allow RDS access from EC2"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow database access from EC2"
    from_port       = var.port
    to_port         = var.port
    protocol        = "tcp"
    security_groups = [var.ec2_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-rds-sg"
  }
}

resource "aws_db_instance" "rds" {
  identifier             = "${var.project}-db"
  allocated_storage      = 20
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  username               = var.username
  password               = var.password
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
  publicly_accessible    = false

  tags = {
    Name = "${var.project}-rds"
  }
}
