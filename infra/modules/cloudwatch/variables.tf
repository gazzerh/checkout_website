variable "vpc" {
  description = "VPC the application should be deployed in"
}

variable "private_subnets" {
  description = "List of private subnets"
}

variable "app_name" {
  description = "Name of application being deployed"
}

variable "log_retention_in_days" {
  description = "How many days are logs retained"
  default     = 7
}

variable "cloudwatch_group_name" {
  description = "Name of new cloudwatch log group"
}
