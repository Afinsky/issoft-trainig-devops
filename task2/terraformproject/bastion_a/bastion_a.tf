resource "aws_instance" "bastion-a" {
  ami           = var.AWS_NAT_AMI
  instance_type = var.instance_type

  subnet_id       = var.sn_id
  key_name        = var.key_id
  security_groups = [var.sg_id]

  associate_public_ip_address = true

  tags = {
    Name = "tera-abotyan-bastion-a"
  }
}
