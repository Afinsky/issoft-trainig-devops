variable "AWS_NAT_AMI" {
  default = "ami-04b9e92b5572fa0d1"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "sn_id" {
  type = "string"
}

variable "key_id" {
  type = "string"
}

variable "sg_id" {
  type = "string"
}
