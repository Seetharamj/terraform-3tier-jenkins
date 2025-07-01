# Project-wide
project = "3-Tier-Project"
region  = "us-east-1"

# VPC and Subnets
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"
az                  = "us-east-1a"

# EC2
ami_id         = "ami-0c55b159cbfafe1f0"   # ✅ Replace with a valid AMI ID in your region
instance_type  = "t2.micro"
key_name       = "your-key-name"          # ✅ Replace with your actual EC2 Key Pair name

# ALB
public_subnet_ids = ["subnet-0abc1234567890def"]  # ✅ Replace with real public subnet IDs after VPC creation
asg_name          = "demo-asg"                   # Will be overridden by module output, but required if passed

# RDS
rds_engine         = "mysql"
rds_engine_version = "8.0"
rds_instance_class = "db.t3.micro"
rds_port           = 3306
db_username        = "admin"
db_password        = "YourStrongPassword123!"    # 🔒 Consider using environment variables or secrets manager
