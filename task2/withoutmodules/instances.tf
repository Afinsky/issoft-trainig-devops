resource "aws_instance" "nat-a" {
  ami                         = var.AWS_NAT_AMI
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.nat-key.id
  security_groups             = [aws_security_group.nat-sg.id]
  subnet_id                   = aws_subnet.sn-public.id
  associate_public_ip_address = true
  source_dest_check           = false

  user_data = <<EOF
#!/bin/bash
sudo iptables -t nat -A POSTROUTING -o eth0 -s 10.11.0.0/16 -j MASQUERADE
EOF

  tags = {
    Name = "tera-abotyan-training-nat-a"
  }
}

resource "aws_eip" "nat-a" {
  instance = aws_instance.nat-a.id
  vpc      = true
}


resource aws_key_pair "nat-key" {
  key_name   = "nat-key"
  public_key = file(var.PUBLIC_KEY_PATH)
}
