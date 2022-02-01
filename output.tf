output "privx-public-fqdn" {
  value = aws_route53_record.privx_dns_record.fqdn
}

output "database_password" {
  value     = random_password.database_password.result
  sensitive = true
}

output "superuser_password" {
  value     = random_password.superuser_password.result
  sensitive = true
}
