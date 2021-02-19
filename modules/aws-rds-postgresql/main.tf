resource "aws_db_instance" "default" {
  allocated_storage      = var.allocated_storage
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = var.engine_version
  instance_class         = var.instance_type
  name                   = var.database_name
  username               = var.database_username
  password               = var.database_password
  vpc_security_group_ids = var.security_group
  skip_final_snapshot    = true

  tags = {
    Name      = "PRIVXDB"
    Terraform = "True"
  }
}
