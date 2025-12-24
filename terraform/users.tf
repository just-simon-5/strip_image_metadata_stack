resource "aws_iam_user" "user_a" {
  name = local.user_a
}

resource "aws_iam_access_key" "user_a" {
  user = aws_iam_user.user_a.name
}

resource "aws_iam_user" "user_b" {
  name = local.user_b
}

resource "aws_iam_access_key" "user_b" {
  user = aws_iam_user.user_b.name
}
