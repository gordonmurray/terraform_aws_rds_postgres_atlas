# KMS key used by Secrets Manager for RDS
resource "aws_kms_key" "kms" {
  description             = "KMS key for Postgres"
  deletion_window_in_days = 30
  is_enabled              = true
  enable_key_rotation     = true

  tags = {
    Name = var.default_tag
  }
}
