variable "acm_region" {}
variable "acm_verification_record_name" {}
variable "acm_verification_record_value" {}
variable "cloudfront_origin_id" {}
variable "domain" {}
variable "environment" {}
variable "host" {}
variable "region" {}

provider "aws" {
  region = "${var.region}"
}

provider "aws" {
  alias  = "acm_region"
  region = "${var.acm_region}"
}

terraform {
  backend "s3" {}
}

module "static_site" {
  source = "../../modules/static_site"

  acm_region                    = "${var.acm_region}"
  acm_verification_record_name  = "${var.acm_verification_record_name}"
  acm_verification_record_value = "${var.acm_verification_record_value}"
  bucket_name                   = "${var.environment}.${var.domain}"
  cloudfront_origin_id          = "${var.cloudfront_origin_id}"
  domain                        = "${var.domain}"
  environment                   = "${var.environment}"
  fqdn                          = "${var.domain}"
  host                          = "${var.host}"
}
