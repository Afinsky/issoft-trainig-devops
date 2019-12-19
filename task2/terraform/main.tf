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


module "frontend_subnet" {
  source             = "./modules/subnets/frontend_subnet"
  vpc_id             = module.vpc.vpc_id
  availability_zones = var.availability_zones
  cidr_block         = var.cidr_block
}

module "infra_subnet" {
  source             = "./modules/subnets/infra_subnet"
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

module "private_lb_subnet" {
  source             = "./modules/subnets/private_lb_subnet"
  vpc_id             = module.vpc.vpc_id
  availability_zones = var.availability_zones
  cidr_block         = var.cidr_block
}








module "key" {
  source       = "./modules/key"
  key_name     = var.key_name
  pub_key_path = var.pub_key_path
}


module "ssh_sg" {
  source = "./modules/securegroups/ssh_sg"
  vpc_id = module.vpc.vpc_id
}


module "http_https_sg" {
  source     = "./modules/securegroups/http_https_sg"
  vpc_id     = module.vpc.vpc_id
  cidr_block = var.cidr_block
}



######PUBLIC SUBNET#####################
module "nat" {
  source             = "./modules/instances/nat"
  aws_ami            = var.aws_ami
  nat_instance_type  = var.nat_instance_type
  availability_zones = var.availability_zones
  cidr_block         = var.cidr_block
  key_id             = module.key.key_id
  sg_id              = module.http_https_sg.sg_id
  sn_id              = module.public_subnet.sn_id
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

#Module "public_alb_instance" {
#  source = "./modules/instances/public_alb/alb/public_alb_instance"
#  sg_id  = module.http_https_sg.sg_id
#  sn_id  = module.public_subnet.sn_id
#}
#
#Module "public_alb_listener" {
#  source            = "./modules/instances/public_alb/alb/public_alb_listener"
#  load_balancer_arn = module.public_alb_instance.alb_arn
#}

#module "public_alb_listener443" {
#  source            = "./modules/instances/public_alb/alb/public_alb_listener"
#  load_balancer_arn = module.public_alb_instance.alb_arn
#  target_gr_arn     = ??????????????????????????????
#}

##############END PUBLIC##########################




###########FRONT SUBNET########################
module "frontend" {
  source             = "./modules/instances/front"
  aws_ami            = var.aws_ami
  front_instance_type  = var.front_instance_type
  availability_zones = var.availability_zones
  key_id             = module.key.key_id
  sg_id              = module.http_https_sg.sg_id
  sn_id              = module.frontend_subnet.sn_id
}
################END FRONT######################

############APP SUBNET########################
module "be" {
  source             = "./modules/instances/be"
  aws_ami            = var.aws_ami
  app_instance_type  = var.app_instance_type
  availability_zones = var.availability_zones
  key_id             = module.key.key_id
  sg_id              = module.http_https_sg.sg_id
  sn_id              = module.application_subnet.sn_id
}
#################END APP###################



###################INFRA SUBNET########################
module "jenkins" {
  source                = "./modules/instances/jenkins"
  aws_ami               = var.aws_ami
  jenkins_instance_type = var.jenkins_instance_type
  availability_zones    = var.availability_zones
  key_id                = module.key.key_id
  sg_id                 = module.http_https_sg.sg_id
  sn_id                 = module.infra_subnet.sn_id
}

module "jenkins_slave" {
  source                = "./modules/instances/jenkins_slave"
  aws_ami               = var.aws_ami
  jenkins_slave_instance_type = var.jenkins_slave_instance_type
  availability_zones    = var.availability_zones
  key_id                = module.key.key_id
  sg_id                 = module.http_https_sg.sg_id
  sn_id                 = module.infra_subnet.sn_id
}

module "nexus" {
  source                = "./modules/instances/nexus"
  aws_ami               = var.aws_ami
  nexus_instance_type = var.nexus_instance_type
  availability_zones    = var.availability_zones
  key_id                = module.key.key_id
  sg_id                 = module.http_https_sg.sg_id
  sn_id                 = module.infra_subnet.sn_id
}


module "sonar" {
  source                = "./modules/instances/sonar"
  aws_ami               = var.aws_ami
  sonar_instance_type = var.sonar_instance_type
  availability_zones    = var.availability_zones
  key_id                = module.key.key_id
  sg_id                 = module.http_https_sg.sg_id
  sn_id                 = module.infra_subnet.sn_id
}

##################END INFRA##########################


###############BACK BALANCER SUBNET##################

####################################

##############END BACK BALANCER#####################


#################INSTANCE DON'T NEED, BECAUSE WE HAVE RDS#######
##module "db" {
##  source             = "./modules/instances/db"
##  aws_ami            = var.aws_ami
##  db_instance_type   = var.db_instance_type
##  availability_zones = var.availability_zones
##  key_id             = module.key.key_id
##  sg_id              = module.db_sg.sg_id
##  sn_id              = module.database_subnet.sn_id
##}
#################################################################



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


module "frontend_association" {
  source             = "./modules/routing/frontend_association"
  availability_zones = var.availability_zones
  sn_id              = module.frontend_subnet.sn_id
  rt_id              = module.private_rt.rt_id
}

module "infra_association" {
  source             = "./modules/routing/infra_association"
  availability_zones = var.availability_zones
  sn_id              = module.infra_subnet.sn_id
  rt_id              = module.private_rt.rt_id
}

module "private_lb_association" {
  source             = "./modules/routing/private_lb_association"
  availability_zones = var.availability_zones
  sn_id              = module.private_lb_subnet.sn_id
  rt_id              = module.private_rt.rt_id
}











module "rds_sn_group" {
  source = "./modules/instances/rds/rds_sn_group"
  sn_id  = module.database_subnet.sn_id
}

module "rds_instance" {
  source            = "./modules/instances/rds/rds_db"
  rds_instance_type = var.rds_instance_type
  rds_endpoint      = var.rds_endpoint
  db_name           = var.db_name
  db_user           = var.db_user
  db_password       = var.db_password
  db_group_name     = module.rds_sn_group.db_sn_group_id
}
