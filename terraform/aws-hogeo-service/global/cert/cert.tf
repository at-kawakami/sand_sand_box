resource "aws_acm_certificate" "cert" {
  domain_name               = "*.${var.domain_name}"
  key_algorithm             = "RSA_2048"
  subject_alternative_names = ["*.${var.domain_name}"]
  tags                      = {}
  tags_all                  = {}
  validation_method         = "DNS"
  options {
    certificate_transparency_logging_preference = "ENABLED"
  }
}
