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

resource "aws_s3_bucket" "bucket_b" {
  bucket = "${local.name}-bucket-b-${var.environment}"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_b_encryption" {
  bucket = aws_s3_bucket.bucket_b.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket_b_lifecycle" {
  bucket = aws_s3_bucket.bucket_b.id
  rule {
    id = "intelligent_tiering"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    status = "Enabled"
  }
}
