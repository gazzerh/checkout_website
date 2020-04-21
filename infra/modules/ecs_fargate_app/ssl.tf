#locals {
#  fqdn_parts  = split(".", var.fqdn)
#  host_part   = split(".", var.fqdn)[0]
#  domain_part = join(".", (slice(local.fqdn_parts, 1, length(local.fqdn_parts))))
#}

data "aws_route53_zone" "zone" {
  name = format("%s.", var.fqdn)
}

resource "aws_route53_record" "alias" {
  zone_id = data.aws_route53_zone.zone.id
  name    = format("%s", data.aws_route53_zone.zone.name)
  type    = "A"

  alias {
    name                   = aws_alb.load_balancer.dns_name
    zone_id                = aws_alb.load_balancer.zone_id
    evaluate_target_health = true
  }
}

resource "aws_acm_certificate" "acm_cert" {
  domain_name       = format("%s", aws_route53_record.alias.name)
  validation_method = "DNS"
}

resource "aws_route53_record" "cert_validation_record" {
  name    = aws_acm_certificate.acm_cert.domain_validation_options.0.resource_record_name
  zone_id = data.aws_route53_zone.zone.id
  type    = aws_acm_certificate.acm_cert.domain_validation_options.0.resource_record_type
  records = [aws_acm_certificate.acm_cert.domain_validation_options.0.resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.acm_cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation_record.fqdn]
}
