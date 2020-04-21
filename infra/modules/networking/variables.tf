variable "region" {
  description = "Which region to deploy into"
  default     = "eu-west-2"
}

variable "app_name" {
  description = "Name of application being deployed"
}

variable "cidr_block" {
  description = "What CIDR block should be assigned to the VPC"
  default     = "10.10.0.0/16"
}

variable "az_number" {
  description = "How many AZ's do we want to deploy into"
  default     = 2
}

data "aws_availability_zones" "available" {
  state = "available"
}
