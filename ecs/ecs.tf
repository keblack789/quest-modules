resource "aws_ecs_cluster" "cluster" {
  name = "${var.env}-${var.service}-cluster"
}

resource "aws_ecs_service" "service" {
  name            = "${var.env}-${var.service}"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = data.aws_subnets.ecs.ids
    assign_public_ip = false
    security_groups  = [aws_security_group.ecs.id]
  }
  load_balancer {
   target_group_arn = aws_alb_target_group.ecs.arn
   container_name   = "${var.env}-${var.service}-container"
   container_port   = var.port 
  }
  desired_count = 2
}

resource "aws_ecs_task_definition" "task" {
  family                   = "${var.env}-${var.service}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = "1024"
  cpu                      = "512"
  execution_role_arn       = "arn:aws:iam::980111423247:role/ecsTaskExecutionRole"

  container_definitions    = <<EOF
  [
    {
      "name": "${var.env}-${var.service}-container",
      "image": "${var.image}",
      "memory": 1024,
      "cpu": 512,
      "essential": true,
      "portMappings": [
        {
          "containerPort": ${var.port},
          "hostPort": ${var.port}
        }
      ],
      "environment": [
        {
          "name": "SECRET_WORD",
          "value": "TwelveFactor"
        }
      ]
    }
  ]
  EOF
}