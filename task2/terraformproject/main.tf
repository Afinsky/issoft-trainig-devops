provider "aws" {
  region                  = var.AWS_REGION
  shared_credentials_file = "~/.aws/credentials"
  assume_role {
    role_arn = "arn:aws:iam::242906888793:role/AWS_Sandbox"
  }
}

module "vpc" {
  source = "./vpc"
}

#module "igw" {
#  source = "./igw"
#  vpc_id = module.vpc.vpc_id
#}
