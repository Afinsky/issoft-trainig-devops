###IGW for VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "tera-abotyan-training-igw"
  }
}


#######################################ROUTE TABLE#######################################


resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name" = "tera-abotyan-training-rt"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = aws_instance.nat-a.id
  }

  tags = {
    "Name" = "tera-abotyan-training-rt-nat-a"
  }
}


################################ROUTE associations######################################
resource "aws_route_table_association" "public-association" {
  subnet_id      = aws_subnet.sn-public.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "backend-association" {
  subnet_id      = aws_subnet.sn-private-be-a.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "db-association" {
  subnet_id      = aws_subnet.sn-private-db-a.id
  route_table_id = aws_route_table.private-rt.id
}


##########################SECURITY group##################################################


resource "aws_security_group" "nat-sg" {
  name        = "tera-abotyan-sg-nat"
  description = "My First SecurityGroup"
  vpc_id      = aws_vpc.vpc.id


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.11.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tera-abotyan-training-sg-nat"
  }
}
