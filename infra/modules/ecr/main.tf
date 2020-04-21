terraform {
  required_providers {
    aws = "~> 2.58"
  }
}

data "aws_ecr_repository" "container_image" {
  name = var.app_name
}
