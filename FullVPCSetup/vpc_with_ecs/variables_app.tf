##### App Variables
variable "app_name" {
  type = string
  description = "Application name"
}

variable "admin_sources_cidr" {
  type = list(string)
  description = "List of IPv4 CIDR blocks from which to allow admin access"
}

variable "app_sources_cidr" {
  type = list(string)
  description = "List of IPv4 CIDR blocks from which to allow application access"
}

##### Docker Variables
variable "docker_app_name" {
  description = "Name of Application Container"
  default = "nginx"
}

variable "docker_app_image" {
  description = "Docker image to run in the ECS cluster"
  default = "nginx:latest"
}

variable "docker_app_port" {
  description = "Port exposed by the Docker image to redirect traffic to"
  default = 80
}

variable "docker_app_count" {
  description = "Number of Docker containers to run"
  default = 2
}

variable "docker_fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default = "1024"
}

variable "docker_fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default = "2048"
}