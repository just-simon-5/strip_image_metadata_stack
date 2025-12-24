resource "aws_s3_bucket_policy" "bucket_a_policy" {
  bucket = aws_s3_bucket.bucket_a.id
  policy = data.aws_iam_policy_document.bucket_a_policy.json
}

data "aws_iam_policy_document" "bucket_a_policy" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [
      "${aws_s3_bucket.bucket_a.arn}/*",
      aws_s3_bucket.bucket_a.arn,
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn-of-lambda", #TODO
      ]
    }
  }
}
