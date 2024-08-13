resource "aws_default_vpc" "ecs-vpc" {
  tags = {
    Name = "ECS-VPC"
  }
}

resource "aws_default_subnet" "ecs_az1" {
  availability_zone = "ap-south-1a"

  tags = {
    Name = "subnet for ap-south-1a"
  }
}

resource "aws_default_subnet" "ecs_az2" {
  availability_zone = "ap-south-1b"

  tags = {
    Name = "subnet for ap-south-1b"
  }
}

resource "aws_default_subnet" "ecs_az3" {
  availability_zone = "ap-south-1c"

  tags = {
    Name = "Default subnet for ap-south-1c"
  }
}



resource "aws_security_group" "my_sg" {
  vpc_id = aws_default_vpc.ecs-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
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