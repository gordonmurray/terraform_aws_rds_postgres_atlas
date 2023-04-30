# Postgres on AWS RDS with Atlas for database migrations

Make a Postgres database on RDS, create and store the admin password in Secrets Manager, use Atlas to create database schemas and tables


## Install [Atlas](https://atlasgo.io/getting-started)

You will need to install the Atlas provider before running a Terraform plan:

> curl -sSf https://atlasgo.sh | sh

Create a schema and a table in HCL format, for example:

```
schema "public" {}
schema "imdb" {}

table "movies" {
    schema = schema.imdb
    column "movie_id" {
        type = int not null
    }
    column "name" {
        type = varchar
    }
    column "certificate" {
        type = varchar
    }
    column "playtime" {
        type = int
    }
    column "release_date" {
        type = date
    }
    column "details" {
        type = varchar
    }

}
```

Then run terraform to create the Postgres instance in RDS and create the schema and table also

```
terraform init
terraform apply
```


## Estimated cost

```
Project: gordonmurray/terraform_aws_rds_postgres_atlas

 Name                                                             Monthly Qty  Unit                    Monthly Cost

 aws_db_instance.postgres
 ├─ Database instance (on-demand, Single-AZ, db.t4g.micro)                730  hours                         $12.41
 ├─ Storage (general purpose SSD, gp2)                                     10  GB                             $1.27
 └─ Additional backup storage                               Monthly cost depends on usage: $0.095 per GB

 aws_kms_key.kms
 ├─ Customer master key                                                     1  months                         $1.00
 ├─ Requests                                                Monthly cost depends on usage: $0.03 per 10k requests
 ├─ ECC GenerateDataKeyPair requests                        Monthly cost depends on usage: $0.10 per 10k requests
 └─ RSA GenerateDataKeyPair requests                        Monthly cost depends on usage: $0.10 per 10k requests

 aws_secretsmanager_secret.secret
 ├─ Secret                                                                  1  months                         $0.40
 └─ API requests                                            Monthly cost depends on usage: $0.05 per 10k requests

 OVERALL TOTAL                                                                                               $15.08
──────────────────────────────────
9 cloud resources were detected:
∙ 3 were estimated, 2 of which include usage-based costs, see https://infracost.io/usage-file
∙ 6 were free:
  ∙ 2 x aws_security_group_rule
  ∙ 1 x aws_db_parameter_group
  ∙ 1 x aws_db_subnet_group
  ∙ 1 x aws_secretsmanager_secret_version
  ∙ 1 x aws_security_group
```

## Clean up

Use `terraform destry` to clean up.

AWS Secrets manager won't fully delete the secret. You can delete it using the CLI if you want to, using:

> aws secretsmanager delete-secret --secret-id postgres_admin --force-delete-without-recovery --region eu-west-1 --profile [YOUR PROFILE]