resource "aws_lb" "ecs" {
  name               = "${var.env}-${var.service}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = data.aws_subnets.alb.ids
 
  enable_deletion_protection = false
}
 
resource "aws_alb_target_group" "ecs" {
  name        = "${var.env}-${var.service}-tg"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
 
  health_check {
   healthy_threshold   = "3"
   interval            = "30"
   protocol            = "HTTP"
   matcher             = "200"
   timeout             = "3"
   path                = "/"
   unhealthy_threshold = "2"
  }
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_lb.ecs.id
  port              = 443
  protocol          = "HTTPS"
 
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.alb_cert_arn
 
  default_action {
    target_group_arn = aws_alb_target_group.ecs.id
    type             = "forward"
  }
}