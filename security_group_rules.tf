resource "aws_security_group_rule" "rds_ingress_1" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.postgres_sg.id
  description       = "Postgres access"
}

resource "aws_security_group_rule" "rds_egress_1" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.postgres_sg.id
  description       = "Allow all out"
}
