# resource "aws_ecs_cluster" "medusa" {
#   name = "medusa-cluster"
# }

# resource "aws_ecs_task_definition" "medusa" {
#   family                   = "medusa-task"
#   requires_compatibilities = ["FARGATE"]
#   cpu                      = "512"
#   memory                   = "1024"
#   network_mode             = "awsvpc"
#   execution_role_arn       = aws_iam_role.ecs_execution.arn

#   container_definitions = jsonencode([
#     {
#       name      = "medusa"
#       image     = "${aws_ecr_repository.medusa_repo.repository_url}:latest"
#       essential = true
#       portMappings = [{
#         containerPort = 9000
#         protocol      = "tcp"
#       }]
#     }
#   ])
# }

# resource "aws_ecs_service" "medusa" {
#   name            = "medusa-service"
#   cluster         = aws_ecs_cluster.medusa.id
#   task_definition = aws_ecs_task_definition.medusa.arn
#   launch_type     = "FARGATE"

#   desired_count = 1

#   network_configuration {
#     subnets         = aws_subnet.public[*].id
#     assign_public_ip = true
#     security_groups = [aws_security_group.ecs_sg.id]
#   }

#   load_balancer {
#     target_group_arn = aws_lb_target_group.medusa_tg.arn
#     container_name   = "medusa"
#     container_port   = 9000
#   }

#   depends_on = [aws_lb_listener.front_end]
# }


resource "aws_security_group" "ecs_sg" {
  name        = "ecs-security-group"
  description = "Security group for ECS service"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_cluster" "medusa" {
  name = "medusa-cluster"
}

resource "aws_ecs_task_definition" "medusa" {
  family                   = "medusa-task"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_execution.arn

  container_definitions = jsonencode([{
    name      = "medusa"
    image     = "${aws_ecr_repository.medusa.repository_url}:latest"
    essential = true
    portMappings = [{
      containerPort = 9000
      protocol      = "tcp"
    }]
  }])
}

resource "aws_ecs_service" "medusa" {
  name            = "medusa-service"
  cluster         = aws_ecs_cluster.medusa.id
  task_definition = aws_ecs_task_definition.medusa.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = aws_subnet.public[*].id
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.medusa_tg.arn
    container_name   = "medusa"
    container_port   = 9000
  }

  depends_on = [aws_lb_listener.front_end]
}