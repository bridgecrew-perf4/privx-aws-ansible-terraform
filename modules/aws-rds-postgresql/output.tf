output "database_address" {
  value       = aws_db_instance.default.address
  description = "DNS name of database instance"
}
