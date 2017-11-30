resource "aws_s3_bucket" "main" {
  bucket = "${var.bucket_name}"
  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}
