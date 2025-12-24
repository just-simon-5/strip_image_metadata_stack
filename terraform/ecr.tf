resource "aws_ecr_repository" "strip_image_metadata" {
  name                 = "${local.name}-repository"
  image_tag_mutability = "IMMUTABLE_WITH_EXCLUSION"

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability_exclusion_filter {
    filter      = "latest"
    filter_type = "WILDCARD"
  }

  encryption_configuration {
    encryption_type = "AES256"
  }
}
