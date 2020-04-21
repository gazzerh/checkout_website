resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.eu-west-2.s3"

  vpc_endpoint_type = "Gateway"
}

resource "aws_vpc_endpoint_route_table_association" "private_s3" {
  route_table_id  = aws_route_table.private_route_table.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}
