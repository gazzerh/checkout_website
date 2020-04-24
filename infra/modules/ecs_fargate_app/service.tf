locals {
  container_definition = [
    {
      "name" : var.container_definition.name,
      "image" : var.container_definition.image,
      "essential" : true,
      "networkMode" : "awsvpc",
      "portMappings" : [
        {
          "containerPort" : var.container_definition.container_port,
          "protocol" : "tcp"
        }
      ],
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-group" : "${var.cloudwatch_log_group.name}",
          "awslogs-region" : "${var.region}",
          "awslogs-stream-prefix" : "ecs"
        }
      }
    }
  ]
}

resource "aws_ecs_task_definition" "ecs_task" {
  family                   = format("%s-task", var.app_name)
  memory                   = var.task_resources.memory
  cpu                      = var.task_resources.cpu
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.ecs_task_execution_role.arn
  container_definitions    = jsonencode(local.container_definition)
}

resource "aws_ecs_service" "ecs_service" {
  cluster         = var.ecs_cluster.name
  task_definition = "${aws_ecs_task_definition.ecs_task.family}:${aws_ecs_task_definition.ecs_task.revision}"
  desired_count   = var.desired_count
  launch_type     = "FARGATE"
  network_configuration {
    security_groups  = [var.ecs_sg.id]
    subnets          = var.private_subnets
    assign_public_ip = false
  }
  load_balancer {
    target_group_arn = aws_alb_target_group.target_group.arn
    container_name   = format("%s-container", var.app_name)
    container_port   = var.container_definition.container_port
  }
  name = format("%s-service", var.app_name)
}
