resource "aws_security_group" "app_lb" {
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ingress" {
  count = length(var.alb_ingress_ports)

  type              = "ingress"
  from_port         = var.alb_ingress_ports[count.index]
  to_port           = var.alb_ingress_ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_lb.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_lb.id
}

resource "aws_security_group_rule" "backend_ingress" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = -1
  source_security_group_id = aws_security_group.app_lb.id
  security_group_id        = var.ecs_sg.id
}
