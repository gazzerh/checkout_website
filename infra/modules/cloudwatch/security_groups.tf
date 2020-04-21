resource "aws_security_group" "vpc_endpoint_sg" {
  vpc_id = var.vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc.cidr_block]
  }
}

#resource "aws_security_group_rule" "endpoint_ingress" {
#  count = length(var.security_group_ids)
#
#  type                     = "ingress"
#  from_port                = 0
#  to_port                  = 0
#  protocol                 = -1
#  source_security_group_id = var.security_group_ids[count.index]
#  security_group_id        = aws_security_group.vpc_endpoint_sg.id
#}
#
