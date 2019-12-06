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




module "public_subnet" {
  source = "./public_subnet"
  vpc_id = module.vpc.vpc_id
}

module "private_subnet_be" {
  source = "./private_subnet_be"
  vpc_id = module.vpc.vpc_id
}

module "private_subnet_db" {
  source = "./private_subnet_db"
  vpc_id = module.vpc.vpc_id
}




module "public_rt" {
  source = "./public_rt"
  vpc_id = module.vpc.vpc_id
  igw_id = module.igw.igw_id
}

module "private_rt" {
  source = "./private_rt"

}
