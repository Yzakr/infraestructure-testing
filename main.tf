terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-1"
}

// EC2 Alternative
resource "aws_instance" "app_server" {
  count         = 1 // How many servers do you need?
  ami           = "ami-04a50faf2a2ec1901"
  instance_type = "t2.micro" // It's free

  tags = {
    Name        = "ExampleAppServerInstance ${count.index}"
    Environment = "Development"
  }
}

// ECS Fargate Alternative
resource "aws_ecs_cluster" "main" {
  name = "cluster-1"
}

resource "aws_ecs_task_definition" "main" {
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  
  container_definitions = jsonencode([{
   name        = "ExampleAppServerContainer"
   image       = "ExampleAppServerImage:latest"
   cpu                      = 2
   memory                   = 512
   essential   = true
   environment = "production" // Definition needed for every type of deployment
   portMappings = [{
     protocol      = "tcp"
     containerPort = 8081
     hostPort      = 80 // Just for testing, better 443
   }]
}

//We also need to declare VPC network rules and roles if we want to interact with other services.
