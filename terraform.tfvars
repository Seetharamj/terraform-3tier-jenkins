project = "my-3tier-app"

region = "us-east-1"

# Networking
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
azs = ["us-east-1a", "us-east-1b"]

# EC2 Configuration
ami_id = "ami-05ffe3c48a9991133"  # Amazon Linux 2 AMI (replace with your desired AMI)
instance_type = "t3.micro"
key_name = "jenkins"    # Replace with your EC2 key pair name

# Auto Scaling Configuration
min_size = 1
max_size = 2
desired_capacity = 1

# RDS Configuration
rds_engine = "mysql"
rds_engine_version = "8.0"
rds_instance_class = "db.t3.micro"
rds_port = 3306
db_username = "admin"
db_password = "Seetharam123" 
