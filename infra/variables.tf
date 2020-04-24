variable "region" {
  description = "Which Region to deploy into"
  default     = "eu-west-2"
}

variable "app_name" {
  description = "Name of application being deployed"
  default     = "company-website"
}

variable "app_version" {
  description = "Version of the application that should be deployed"
  default     = "v0.4"
}

variable "fqdn" {
  description = "FQDN of the hosted application"
  default     = "checkout.gazzerh.co.uk"
}

variable "cidr_block" {
  description = "What CIDR block should be assigned to the app's VPC"
  default     = "10.10.1.0/24"
}

variable "az_number" {
  description = "How many AZ's do we want to deploy into"
  default     = 2
}

variable "alb_ingress_ports" {
  type        = list
  description = "List of ports the alb should listen on"
  default     = ["80", "443"]
}

variable "log_retention_in_days" {
  description = "How many days are logs retained"
  default     = 7
}
