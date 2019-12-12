variable "environment" {
  type    = "string"
  default = "demo"
}

variable "region" {
  type = "string"
}

variable "availability_zones" {
  type = "list"
}

variable "bastion_instance_type" {
  type = "string"
}

variable "nat_instance_type" {
  type = "string"
}

variable "proxy_instance_type" {
  type = "string"
}

variable "app_instance_type" {
  type = "string"
}

variable "db_instance_type" {
  type = "string"
}

variable "cidr_block" {
  type        = "string"
  description = "VPC cidr block. Exaple: 10.10.0.0/16"
}

variable "key_name" {
  type = "string"
}

variable "pub_key_path" {
  type = "string"
}

variable "aws_ami" {
  type = "string"
}

variable "rds_instance_type" {
  type = "string"
}

variable "db_name" {}

variable "db_user" {}

variable "db_password" {}
