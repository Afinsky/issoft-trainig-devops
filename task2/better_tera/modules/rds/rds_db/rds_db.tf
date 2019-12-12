resource "aws_db_instance" "rds_mysql" {
  allocated_storage           = 20
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "5.7"
  instance_class              = var.rds_instance_type
  name                        = var.db_name
  username                    = var.db_user
  password                    = var.db_password
  parameter_group_name        = "default.mysql5.7"
  db_subnet_group_name        = var.db_group_name
  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = true
  backup_retention_period     = 35
  backup_window               = "22:00-23:00"
  maintenance_window          = "Sat:00:00-Sat:03:00"
  multi_az                    = false
  skip_final_snapshot         = true
}
