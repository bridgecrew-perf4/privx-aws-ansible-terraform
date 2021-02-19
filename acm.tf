#ACM CONFIGURATION
#Creates ACM certificate and requests validation via DNS(Route53)
resource "aws_acm_certificate" "privx-acm" {
  domain_name       = var.public-fqdn
  validation_method = "DNS"
  tags = {
    Name = var.public-fqdn
  }
}


#Validates ACM issued certificate via Route53
resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.privx-acm.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}


