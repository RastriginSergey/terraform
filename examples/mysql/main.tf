provider "aws" {
  region = "eu-central-1"
  profile = "terraform"
}

module "mysql" {
  source = "../../modules/data-sources/mysql"

  prefix = "terraform-up-and-running"
  name = "exampledatabase"
  db_password = var.password
  username = var.username
}