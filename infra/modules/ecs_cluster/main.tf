terraform {
  required_providers {
    aws = "~> 2.58"
  }
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = format("%s-cluster", var.app_name)
}
