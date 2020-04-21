output "ecr_container_image" {
  description = "Container image"
  value       = data.aws_ecr_repository.container_image
}
