variable "project" {
  description = "Name prefix for every resource"
  type        = string
  default     = "ecs-oidc"
}

variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "github_repo" {
  description = "GitHub repository as owner/repo — used in the OIDC trust policy"
  type        = string
}

variable "container_port" {
  type    = number
  default = 8000
}