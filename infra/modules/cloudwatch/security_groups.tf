resource "aws_security_group" "vpc_endpoint_sg" {
  vpc_id = var.vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc.cidr_block]
  }
}
