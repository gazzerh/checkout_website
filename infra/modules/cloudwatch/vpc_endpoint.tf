resource "aws_vpc_endpoint" "cloudwatch" {
  vpc_id            = var.vpc.id
  service_name      = "com.amazonaws.eu-west-2.logs"
  vpc_endpoint_type = "Interface"


  security_group_ids = [
    aws_security_group.vpc_endpoint_sg.id,
  ]

  subnet_ids          = var.private_subnets
  private_dns_enabled = true
}
