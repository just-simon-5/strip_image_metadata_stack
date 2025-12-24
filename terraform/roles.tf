resource "aws_iam_role" "lambda_assume_role" {
  name               = "${local.name}-lambda-assume-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}
