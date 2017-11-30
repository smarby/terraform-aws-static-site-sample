resource "aws_cloudfront_distribution" "s3_distribution" {
  aliases = ["${var.fqdn}"]
  origin {
    domain_name = "${aws_s3_bucket.main.website_endpoint}"
    origin_id   = "${var.cloudfront_origin_id}"
    custom_origin_config {
      origin_protocol_policy = "http-only"
      http_port = "80"
      https_port = "443"
      origin_ssl_protocols = ["TLSv1","TLSv1.1","TLSv1.2"]
    }
  }

  custom_error_response {
    error_caching_min_ttl = 300
    error_code            = "403"
    response_code         = "404"
    response_page_path    = "/404.html"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${var.environment}"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.cloudfront_origin_id}"

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE", "JP"]
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${data.aws_acm_certificate.main.arn}"
    minimum_protocol_version = "TLSv1"
    ssl_support_method  = "sni-only"
  }
}
