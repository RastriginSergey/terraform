provider "aws" {
  region  = "eu-central-1"
  profile = "terraform"
}

terraform {
  backend "s3" {
    key = "prod/services/data-stores/terraform.tfstate"
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "exampedatabase"
  username            = "admin"
  skip_final_snapshot = true

  password = var.db_password
}

# data "aws_secretmanager_secret_version" "db_password" {
#   secret_id = "mysql-master-password-stage"
# }
