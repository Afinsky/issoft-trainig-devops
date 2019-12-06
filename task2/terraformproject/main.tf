provider "aws" {
  region                  = var.AWS_REGION
  shared_credentials_file = "~/.aws/credentials"
  assume_role {
    role_arn = "arn:aws:iam::242906888793:role/AWS_Sandbox"
  }
}


#Add availability_zone as value!!!

module "vpc" {
  source = "./vpc"
}

module "igw" {
  source = "./igw"
  vpc_id = module.vpc.vpc_id
}


#################SUBNETS#######################

module "public_subnet" {
  source = "./public_subnet"
  vpc_id = module.vpc.vpc_id
  az     = var.az
}

module "private_subnet_be" {
  source = "./private_subnet_be"
  vpc_id = module.vpc.vpc_id
  az     = var.az
}

module "private_subnet_db" {
  source = "./private_subnet_db"
  vpc_id = module.vpc.vpc_id
  az     = var.az
}

##############END SUBNETS#######################

####################KEY#########################

module "key" {
  source = "./key"
}

###################END KEY######################


#################SECURITY GROUPS####################
module "nat_sg" {
  source = "./nat_sg"
  vpc_id = module.vpc.vpc_id
}

module "app_sg" {
  source = "./app_sg"
  vpc_id = module.vpc.vpc_id
}

module "ssh_sg" {
  source = "./ssh_sg"
  vpc_id = module.vpc.vpc_id
}

module "db_sg" {
  source = "./db_sg"
  vpc_id = module.vpc.vpc_id
}

module "balancer_sg" {
  source = "./balancer_sg"
  vpc_id = module.vpc.vpc_id
}

#################END SECURITY GROUPS####################

#################EC2 INSTANCES############################

module "nat_a" {
  source = "./nat_a"
  sn_id  = module.public_subnet.sn_id
  key_id = module.key.key_id
  sg_id  = module.nat_sg.sg_id
}

module "balancer_a" {
  source = "./balancer_a"
  sn_id  = module.public_subnet.sn_id
  key_id = module.key.key_id
  sg_id  = module.balancer_sg.sg_id
}

module "bastion_a" {
  source = "./bastion_a"
  sn_id  = module.public_subnet.sn_id
  key_id = module.key.key_id
  sg_id  = module.ssh_sg.sg_id
}

module "be_a" {
  source = "./be_a"
  sn_id  = module.private_subnet_be.sn_id
  key_id = module.key.key_id
  sg_id  = module.app_sg.sg_id
}

module "db_a" {
  source = "./db_a"
  sn_id  = module.private_subnet_db.sn_id
  key_id = module.key.key_id
  sg_id  = module.db_sg.sg_id
}

###################END EC2 INSTANCES########################

##################ROUTE TABLE TO IGW#########################

module "public_rt" {
  source = "./public_rt"
  vpc_id = module.vpc.vpc_id
  igw_id = module.igw.igw_id
}

module "public_association" {
  source = "./public_association"
  sn_id  = module.public_subnet.sn_id
  rt_id  = module.public_rt.rt_id
}
##################END ROUTE TABLE TO IGW#########################


##################ROUTE TABLE TO NAT#########################
module "private_rt" {
  source = "./private_rt"
  vpc_id = module.vpc.vpc_id
  igw_id = module.nat_a.nat-a_id
}

module "be_association" {
  source = "./be_association"
  sn_id  = module.private_subnet_be.sn_id
  rt_id  = module.private_rt.rt_id
}

module "db_association" {
  source = "./db_association"
  sn_id  = module.private_subnet_db.sn_id
  rt_id  = module.private_rt.rt_id
}
##################END ROUTE TABLE TO NAT#########################
