resource "aws_s3_bucket" "bucket_a" {
  bucket = "${local.name}-bucket-a-${var.environment}"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_a_encryption" {
  bucket = aws_s3_bucket.bucket_a.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
