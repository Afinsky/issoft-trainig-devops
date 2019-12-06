variable "AWS_REGION" {
  default = "us-east-1"
}

#variable "public_subnet_cidr" {
#  description = "CIDR for the Public Subnet"
#  default     = "10.11.0.0/24"
#}

#variable "private_subnet_cidr" {
#  description = "CIDR for the Private Subnet"
#  default     = "10.11.1.0/24"
#}

variable "AWS_NAT_AMI" {
  #  default = "ami-01623d7b"
  default = "ami-0a0cb6c7bcb2e4c51"
}

variable "PUBLIC_KEY_PATH" {
  default = "./nat-key.pub"
}
