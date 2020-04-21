terraform {
  required_providers {
    aws = "~> 2.58"
  }
}

resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = var.cloudwatch_group_name
  retention_in_days = var.log_retention_in_days
}
