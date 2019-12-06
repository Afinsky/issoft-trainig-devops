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
  name        = "tera-abotyan-training-sg-nat"
  description = "SG for NAT"
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


###############################################

resource "aws_security_group" "db-sg" {
  name        = "tera-abotyan-training-sg-db"
  description = "SG for DB"
  vpc_id      = aws_vpc.vpc.id


  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.11.10.0/24"]
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
    Name = "tera-abotyan-training-sg-db"
  }
}


###############################################


resource "aws_security_group" "ssh-sg" {
  name        = "tera-abotyan-training-sg-ssh"
  description = "SG for SSH"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["104.59.125.84/32"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["216.70.7.11/32"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["80.94.174.82/32"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["82.209.242.80/29"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["86.57.155.180/32"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["86.57.158.250/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tera-abotyan-training-sg-ssh"
  }
}

###############################################

resource "aws_security_group" "app-sg" {
  name        = "tera-abotyan-training-sg-app"
  description = "SG for app"
  vpc_id      = aws_vpc.vpc.id


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.11.10.0/24"]
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
    Name = "tera-abotyan-training-sg-app"
  }
}


###############################################

resource "aws_security_group" "balancer-sg" {
  name        = "tera-abotyan-training-sg-balancer"
  description = "SG for balancer"
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
    Name = "tera-abotyan-training-sg-balancer"
  }
}
