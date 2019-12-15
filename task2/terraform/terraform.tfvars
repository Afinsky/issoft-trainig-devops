region = "us-east-1"

availability_zones = ["us-east-1a", "us-east-1b"]

bastion_instance_type = "t2.micro"

nat_instance_type = "t2.micro"

proxy_instance_type = "t2.micro"

app_instance_type = "t2.micro"

jenkins_instance_type = "t2.micro"

db_instance_type = "t2.micro"

rds_instance_type = "db.t2.micro"

cidr_block = "10.20.0.0/16"

key_name = "abotyan-tera-key"

pub_key_path = "./abotyan-tera-key.pub"

aws_ami = "ami-04b9e92b5572fa0d1"

rds_endpoint = "dev-botyan-rds"

db_name = "applicationdb"

db_user = "abotyan"

db_password = "yourpassword"
