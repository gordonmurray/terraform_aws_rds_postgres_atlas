
data "atlas_schema" "market" {
  dev_url = "postgres://postgres:${random_password.password.result}@${aws_db_instance.postgres.endpoint}"
  src     = file("schema.hcl")
}

// Sync the state of the target database with the hcl file.
resource "atlas_schema" "market" {
  hcl = data.atlas_schema.market.hcl
  url = "postgres://postgres:${random_password.password.result}@${aws_db_instance.postgres.endpoint}"
}


data "atlas_migration" "users" {
  dir = "migrations?format=atlas"
  url = "postgres://postgres:${random_password.password.result}@${aws_db_instance.postgres.endpoint}"
}

resource "atlas_migration" "users" {
  dir     = "migrations?format=atlas"
  version = ""
  url     = data.atlas_migration.users.url
}
