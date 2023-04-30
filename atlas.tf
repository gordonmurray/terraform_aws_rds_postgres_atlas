
data "atlas_schema" "imdb" {
  dev_url = "postgres://postgres:${random_password.password.result}@${aws_db_instance.postgres.endpoint}"
  src     = file("schema.hcl")
}

// Sync the state of the target database with the hcl file.
resource "atlas_schema" "imdb" {
  hcl = data.atlas_schema.imdb.hcl
  url = "postgres://postgres:${random_password.password.result}@${aws_db_instance.postgres.endpoint}"
}

