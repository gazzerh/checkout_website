output "cloudwatch_log_group" {
  description = "Cloudwatch Log Group"
  value       = aws_cloudwatch_log_group.ecs_logs
}
