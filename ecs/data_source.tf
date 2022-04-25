data "aws_subnets" "alb" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Name = var.alb_subnet
  }
}

data "aws_subnets" "ecs" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Name = var.ecs_subnet
  }
}