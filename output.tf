output "privx_publicdns" {
  value = aws_instance.privx.public_dns
}

output "privx-public-fqdn" {
  value = aws_route53_record.privx_dns_record.fqdn
}

output "database_password" {
  value = random_password.database_password.result
}

output "superuser_password" {
  value = random_password.superuser_password.result
}