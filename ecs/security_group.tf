## ALB SG
resource "aws_security_group" "alb" {
  name        = "${var.env}-${var.service}-alb-sg"
  description = "alb rules for ${var.env} ${var.service} access"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.env}-${var.service}-alb-sg"
  }
}

resource "aws_security_group_rule" "allow_in" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.alb.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_out_alb" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}

## ECS SG
resource "aws_security_group" "ecs" {
  name        = "${var.env}-${var.service}-ecs-sg"
  description = "rules for ${var.env} ${var.service} access"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.env}-${var.service}-ecs-sg"
  }
}

resource "aws_security_group_rule" "allow_alb" {
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  security_group_id = aws_security_group.ecs.id
  source_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "allow_out_ecs" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs.id
}