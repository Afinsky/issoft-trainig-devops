provider "aws" {
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
  assume_role {
    role_arn = "arn:aws:iam::242906888793:role/AWS_Sandbox"
  }
}


module "vpc" {
  source     = "./modules/vpc"
  cidr_block = var.cidr_block
}

module "igw" {
  source = "./modules/igw"
  vpc_id = module.vpc.vpc_id
}

module "public_subnet" {
  source             = "./modules/subnets/public_subnet"
  vpc_id             = module.vpc.vpc_id
  availability_zones = var.availability_zones
  cidr_block         = var.cidr_block
}

module "application_subnet" {
  source             = "./modules/subnets/application_subnet"
  vpc_id             = module.vpc.vpc_id
  availability_zones = var.availability_zones
  cidr_block         = var.cidr_block
}

module "database_subnet" {
  source             = "./modules/subnets/database_subnet"
  vpc_id             = module.vpc.vpc_id
  availability_zones = var.availability_zones
  cidr_block         = var.cidr_block
}

module "key" {
  source       = "./modules/key"
  key_name     = var.key_name
  pub_key_path = var.pub_key_path
}


module "nat_sg" {
  source     = "./modules/securegroups/nat_sg"
  cidr_block = var.cidr_block
  vpc_id     = module.vpc.vpc_id
}

module "app_sg" {
  source     = "./modules/securegroups/app_sg"
  cidr_block = var.cidr_block
  vpc_id     = module.vpc.vpc_id
}

module "ssh_sg" {
  source = "./modules/securegroups/ssh_sg"
  vpc_id = module.vpc.vpc_id
}

module "db_sg" {
  source     = "./modules/securegroups/db_sg"
  cidr_block = var.cidr_block
  vpc_id     = module.vpc.vpc_id
}

module "balancer_sg" {
  source     = "./modules/securegroups/balancer_sg"
  cidr_block = var.cidr_block
  vpc_id     = module.vpc.vpc_id
}


module "jenkins_sg" {
  source     = "./modules/securegroups/jenkins_sg"
  cidr_block = var.cidr_block
  vpc_id     = module.vpc.vpc_id
}



module "nat" {
  source             = "./modules/instances/nat"
  aws_ami            = var.aws_ami
  nat_instance_type  = var.nat_instance_type
  availability_zones = var.availability_zones
  cidr_block         = var.cidr_block
  key_id             = module.key.key_id
  sg_id              = module.nat_sg.sg_id
  sn_id              = module.public_subnet.sn_id
}

module "balancer" {
  source              = "./modules/instances/balancer"
  aws_ami             = var.aws_ami
  proxy_instance_type = var.proxy_instance_type
  availability_zones  = var.availability_zones
  key_id              = module.key.key_id
  sg_id               = module.balancer_sg.sg_id
  sn_id               = module.public_subnet.sn_id
}

module "bastion" {
  source                = "./modules/instances/bastion"
  aws_ami               = var.aws_ami
  bastion_instance_type = var.bastion_instance_type
  availability_zones    = var.availability_zones
  key_id                = module.key.key_id
  sg_id                 = module.ssh_sg.sg_id
  sn_id                 = module.public_subnet.sn_id
}

module "be" {
  source             = "./modules/instances/be"
  aws_ami            = var.aws_ami
  app_instance_type  = var.app_instance_type
  availability_zones = var.availability_zones
  key_id             = module.key.key_id
  sg_id              = module.app_sg.sg_id
  sn_id              = module.application_subnet.sn_id
}


module "jenkins" {
  source                = "./modules/instances/jenkins"
  aws_ami               = var.aws_ami
  jenkins_instance_type = var.jenkins_instance_type
  availability_zones    = var.availability_zones
  key_id                = module.key.key_id
  sg_id                 = module.jenkins_sg.sg_id
  sn_id                 = module.public_subnet.sn_id
}


#module "db" {
#  source             = "./modules/instances/db"
#  aws_ami            = var.aws_ami
#  db_instance_type   = var.db_instance_type
#  availability_zones = var.availability_zones
#  key_id             = module.key.key_id
#  sg_id              = module.db_sg.sg_id
#  sn_id              = module.database_subnet.sn_id
#}

module "public_rt" {
  source = "./modules/routing/public_rt"
  vpc_id = module.vpc.vpc_id
  igw_id = module.igw.igw_id
}

module "public_assotiation" {
  source             = "./modules/routing/public_association"
  availability_zones = var.availability_zones
  sn_id              = module.public_subnet.sn_id
  rt_id              = module.public_rt.rt_id
}


module "private_rt" {
  source             = "./modules/routing/private_rt"
  vpc_id             = module.vpc.vpc_id
  availability_zones = var.availability_zones
  igw_id             = module.nat.nat_id
}

module "be_association" {
  source             = "./modules/routing/be_association"
  availability_zones = var.availability_zones
  sn_id              = module.application_subnet.sn_id
  rt_id              = module.private_rt.rt_id
}


module "db_association" {
  source             = "./modules/routing/db_association"
  availability_zones = var.availability_zones
  sn_id              = module.database_subnet.sn_id
  rt_id              = module.private_rt.rt_id
}




module "rds_sn_group" {
  source = "./modules/rds/rds_sn_group"
  sn_id  = module.database_subnet.sn_id
}

module "rds_instance" {
  source            = "./modules/rds/rds_db"
  rds_instance_type = var.rds_instance_type
  rds_endpoint      = var.rds_endpoint
  db_name           = var.db_name
  db_user           = var.db_user
  db_password       = var.db_password
  db_group_name     = module.rds_sn_group.db_sn_group_id
}
