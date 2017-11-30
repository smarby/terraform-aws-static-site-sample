data "aws_acm_certificate" "main" {
  provider = "aws.acm_region"
  domain   = "${var.fqdn}"
  statuses = ["ISSUED", "PENDING_VALIDATION"]
}
