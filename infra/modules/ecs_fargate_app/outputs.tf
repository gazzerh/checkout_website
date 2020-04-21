
output "ecs_service" {
  description = "Service for use by loadbalancer"
  value       = aws_ecs_service.ecs_service
}

output "app_lb_sg" {
  description = "Security group created for application load balancer"
  value       = aws_security_group.app_lb
}

output "alb_target_group" {
  description = "alb target group for use by ecs cluster scaling"
  value       = aws_alb_target_group.target_group
}
