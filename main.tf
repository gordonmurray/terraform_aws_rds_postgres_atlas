terraform {

  required_version = "1.3.7"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "4.65.0"

    }

    atlas = {
      source  = "ariga/atlas"
      version = "~> 0.4.0"
    }

  }

}

provider "aws" {
  region  = "eu-west-1"
  profile = "gordonmurray"

  default_tags {
    tags = {
      App = "terraform_aws_rds_secrets_manager"
    }
  }
}

provider "atlas" {}
