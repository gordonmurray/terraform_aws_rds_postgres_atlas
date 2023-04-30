resource "aws_secretsmanager_secret" "secret" {
  kms_key_id              = aws_kms_key.kms.key_id
  name                    = "postgres_admin"
  description             = "Postges Admin password"
  recovery_window_in_days = 14

  tags = {
    Name = var.default_tag
  }
}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = random_password.password.result
}
