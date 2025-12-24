resource "aws_lambda_function" "example" {
  function_name = "${local.name}-lambda"
  role          = aws_iam_role.lambda_assume_role.arn
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.strip_image_metadata.repository_url}:latest"
}
