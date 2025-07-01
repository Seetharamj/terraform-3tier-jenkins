project = "tier3-project"
region  = "us-east-1"

vpc_cidr = "10.0.0.0/16"

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.101.0/24",
  "10.0.102.0/24"
]

azs = [
  "us-east-1a",
  "us-east-1b"
]

ami_id         = "ami-0c55b159cbfafe1f0"  # ✅ Replace with latest valid AMI for us-east-1
instance_type  = "t2.micro"
key_name       = "my-key-pair"            # ✅ Replace with your actual key name

rds_engine         = "mysql"
rds_engine_version = "8.0"
rds_instance_class = "db.t3.micro"
rds_port           = 3306
db_username        = "admin"
db_password        = "MySecurePassword123"  # 🔐 Sensitive — consider using environment variable or AWS Secrets Manager
