module "pgsql_database" {
  source            = "./modules/aws-rds-postgresql"
  allocated_storage = var.allocated_storage
  engine_version    = var.engine_version
  instance_type     = var.instance_typedb
  database_name     = var.database_name
  database_username = var.database_username
  database_password = random_password.database_password.result
  security_group    = [aws_security_group.privx-db.id]
}