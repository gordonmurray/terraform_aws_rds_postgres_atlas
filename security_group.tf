resource "aws_security_group" "postgres_sg" {
  name        = "postgres"
  description = "postgres instance security group"
  vpc_id      = var.vpc

  tags = {
    Name = var.default_tag
  }
}