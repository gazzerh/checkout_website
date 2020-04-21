output "vpc" {
  description = "ID of VPC that was created"
  value       = aws_vpc.vpc
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = [for s in aws_subnet.public_subnets : s.id]
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = [for s in aws_subnet.private_subnets : s.id]
}
