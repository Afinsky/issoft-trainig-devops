resource "aws_db_subnet_group" "rds-private-subnet" {
  name = "abotyan-rds-private-subnet-group"
  subnet_ids = var.sn_id

  tags = {
    Name        = "abotyan-db-subnet-group"
    owner       = "abotyan"
    description = "Subnets for RDS"
  }
}
