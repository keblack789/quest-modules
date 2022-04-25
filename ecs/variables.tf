variable "env" {
  description = "AWS environment"
  type    = string
}

variable "service" {
  description = "Name of the service or app"
  type    = string
}

variable "vpc_id" {
  description = "VPC for the cluster"
  type    = string
}

variable "alb_subnet" {
  description = "Prefix for subnets for the load balancer"
  type    = string
}

variable "ecs_subnet" {
  description = "Prefix for subnets for the cluster"
  type    = string
}

variable "port" {
  description = "Port for the service"
  type    = number
}

variable "image" {
  description = "Image to use for the container"
  type    = string
}

variable "alb_cert_arn" {
  description = "ARN of certificate in ACM to use with the load balancer"
  type    = string
}