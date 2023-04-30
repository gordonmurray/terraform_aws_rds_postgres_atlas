variable "default_tag" {
  type        = string
  description = "A default tag to add to everything"
  default     = "terraform_aws_rds_postgres_atlas"
}

variable "vpc" {
  type        = string
  description = "The VPC to use for your instances"
}

variable "subnets" {
  type        = list(any)
  description = "The subnets available in the VPC"
}