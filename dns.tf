#DNS Configuration
data "aws_route53_zone" "dns" {
  name         = var.dns-domain
  private_zone = false
}

# Create Alias record towards ALB from Route53
resource "aws_route53_record" "privx_dns_record" {
  name    = split(".", var.public-fqdn)[0]
  type    = "CNAME"
  zone_id = data.aws_route53_zone.dns.zone_id
  records = [aws_lb.application-lb.dns_name]
  ttl     = "300"
}

# Create Alias record in hosted zone for ACM Certificate Domain Verification
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for val in aws_acm_certificate.privx-acm.domain_validation_options : val.domain_name => {
      name   = val.resource_record_name
      record = val.resource_record_value
      type   = val.resource_record_type
    }
  }
  name    = each.value.name
  records = [each.value.record]
  ttl     = 60
  type    = each.value.type
  zone_id = data.aws_route53_zone.dns.zone_id
}