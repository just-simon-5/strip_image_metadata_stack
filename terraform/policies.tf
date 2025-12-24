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
        aws_iam_role.lambda_assume_role.arn,
      ]
    }
  }
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy" "lambda_inline_policy" {
  name   = "lambda-inline-policy"
  role   = aws_iam_role.lambda_assume_role.id
  policy = data.aws_iam_policy_document.lambda_inline_policy.json
}

data "aws_iam_policy_document" "lambda_inline_policy" {

  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [
      "${aws_s3_bucket.bucket_a.arn}/*",
      aws_s3_bucket.bucket_a.arn,
    ]
  }
  statement {
    actions = [
      "s3:PutObject",
      "s3:ListBucket",
    ]
    resources = [
      "${aws_s3_bucket.bucket_b.arn}/*",
      aws_s3_bucket.bucket_b.arn,
    ]
  }
}

resource "aws_s3_bucket_policy" "bucket_b_policy" {
  bucket = aws_s3_bucket.bucket_b.id
  policy = data.aws_iam_policy_document.bucket_b_policy.json
}

data "aws_iam_policy_document" "bucket_b_policy" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:ListBucket",
    ]
    resources = [
      "${aws_s3_bucket.bucket_b.arn}/*",
      aws_s3_bucket.bucket_b.arn,
    ]
    principals {
      type = "AWS"
      identifiers = [
        aws_iam_role.lambda_assume_role.arn,
      ]
    }
  }
}
