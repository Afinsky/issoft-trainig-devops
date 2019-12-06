variable "public_subnet_cidr" {
  description = "CIDR for the Public Subnet"
  default     = "10.11.0.0/24"
}

variable "vpc_id" {

  type = string

}

variable "az" {}
