variable "vpc_id" {
  description = "VPC the application should be deployed in"
}

variable "region" {
  description = "Which Region to deploy into"
  default     = "eu-west-2"
}

variable "app_name" {
  description = "Name of application being deployed"
}

variable "fqdn" {
  description = "FQDN of the hosted application"
}

variable "task_resources" {
  description = "How many resources to assign to the fargate task"
  default = {
    cpu    = 256
    memory = 512
  }
}

variable "ecs_sg" {
  description = "id of the security group created for ECS"
}

variable "ecs_cluster" {
  description = "ECS application is being deployed to"
}

variable "private_subnets" {
  description = "List of private subnets"
}

variable "ecs_task_execution_role" {
  description = "ECS task execution policy"
}

variable "container_definition" {
  description = "Container which will run the application"
}

variable "cloudwatch_log_group" {
  description = "Which cloudwatch group to store logs"
}

variable "public_subnets" {
  description = "List of public subnets"
}

variable "alb_ingress_ports" {
  description = "List of ports the alb should listen on"
  default     = ["80", "443"]
}
