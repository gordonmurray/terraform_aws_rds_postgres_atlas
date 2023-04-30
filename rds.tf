resource "random_password" "password" {
  length  = 10
  special = false
}

resource "aws_db_subnet_group" "postgres" {
  name       = "postgres_subnet_group"
  subnet_ids = var.subnets

  tags = {
    Name = var.default_tag
  }
}

resource "aws_db_instance" "postgres" {
  identifier              = "postgres-instance"
  allocated_storage       = 10
  storage_type            = "gp2"
  engine                  = "postgres"
  engine_version          = "15.2"
  instance_class          = "db.t4g.micro"
  username                = "postgres"
  password                = random_password.password.result
  parameter_group_name    = aws_db_parameter_group.postgres.name
  skip_final_snapshot     = true
  publicly_accessible     = true
  multi_az                = false
  storage_encrypted       = true
  backup_retention_period = 1
  vpc_security_group_ids  = [aws_security_group.postgres_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.postgres.name


  tags = {
    Name = var.default_tag
  }
}


resource "aws_db_parameter_group" "postgres" {
  name   = "postgres"
  family = "postgres15"
}