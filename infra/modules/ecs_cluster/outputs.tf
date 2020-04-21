output "ecs_sg" {
  description = "Security group created for ECS"
  value       = aws_security_group.ecs_sg
}

output "ecs_cluster" {
  description = "ECS created cluster"
  value       = aws_ecs_cluster.ecs_cluster
}

output "ecs_task_execution_role" {
  description = "ECS task execution policy"
  value       = aws_iam_role.ecs_task_execution_role
}
