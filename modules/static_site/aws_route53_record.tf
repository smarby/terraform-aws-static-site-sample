resource "aws_route53_record" "acm_verification_record" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.acm_verification_record_name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${var.acm_verification_record_value}"]
}

resource "aws_route53_record" "main" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name = "${var.host}"
  type = "A"

  alias {
    name = "${aws_cloudfront_distribution.s3_distribution.domain_name}"
    zone_id = "${aws_cloudfront_distribution.s3_distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}
