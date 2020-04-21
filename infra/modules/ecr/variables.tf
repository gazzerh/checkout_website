variable "vpc" {
  description = "VPC the application should be deployed in"
}

variable "app_name" {
  description = "Name of application being deployed"
}

variable "private_subnets" {
  description = "List of private subnets"
}
