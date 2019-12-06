resource "aws_instance" "be-a" {
  ami           = var.AWS_NAT_AMI
  instance_type = var.instance_type

  subnet_id       = var.sn_id
  key_name        = var.key_id
  security_groups = [var.sg_id]

  associate_public_ip_address = false

  tags = {
    Name = "tera-abotyan-be-a"
  }
}
