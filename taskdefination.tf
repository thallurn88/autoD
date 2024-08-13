resource "aws_ecs_task_definition" "my_first_task" {
  family                   = "my-task-family"
  network_mode             = "awsvpc"  
  requires_compatibilities = ["FARGATE"]  
  memory                   = "512"  
  cpu                      = "256"  

  container_definitions    = <<DEFINITION
[
  {
    "name": "my-first-task",
    "image": "nginx:latest",  
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
DEFINITION
}
