resource "aws_iam_role" "taskrole"{
  name = "terraform-ecs"
  assume_role_policy = <<EOF
  {
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {
         "Service": "ecs-tasks.amazonaws.com"
       },
       "Effect": "Allow",
       "Sid": ""
     }
   ]
  }
  EOF
  managed_policy_arns = ["arn:aws:iam::aws:policy/CloudWatchFullAccess","arn:aws:iam::aws:policy/AmazonECS_FullAccess","arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
}
resource "aws_ecr_repository" "Terraform-bharath" {
  name = "terraform-ecr"
}  
resource "aws_ecs_task_definition" "Terraform-bharath" {
  family = "Terraform-bharath"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 3072
  task_role_arn= aws_iam_role.taskrole.arn
  execution_role_arn= aws_iam_role.taskrole.arn
  container_definitions = jsonencode([
    {
      name      = "Terraform-bharath"
      image     = "928920371678.dkr.ecr.ap-southeast-1.amazonaws.com/bharath:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    },
  ])

}
resource "aws_ecs_cluster" "Terraform-bharath" {
  name = "Terraform-bharath"
}
resource "aws_alb" "alb" {
  name           = "myapp-load-balancer"
  subnets        = var.publicsubnet
  security_groups = var.security
  load_balancer_type = "application" 

}

resource "aws_alb_target_group" "myapp-tg" {
  name        = "myapp-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    protocol            = "HTTP"
    path                = "/"
    interval            = 30
  }
}
resource "aws_alb_listener" "django" {
  load_balancer_arn = aws_alb.alb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.myapp-tg.id
    type = "forward"

    redirect {
      status_code = "HTTP_301"
      protocol = "HTTP"
      port = "80"
    }
  }

}
resource "aws_ecs_service" "Terraform-bharath" {
  name            = "Terraform-bharath"
  cluster         = "Terraform-bharath"
  task_definition = "Terraform-bharath"
  desired_count   = 1
 
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_alb_target_group.myapp-tg.arn
    container_name   = "Terraform-bharath"
    container_port   = 80
  }
  network_configuration {
    security_groups = var.security
    subnets = var.publicsubnet
    assign_public_ip = true 
  }


}
