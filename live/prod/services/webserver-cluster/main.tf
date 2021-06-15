provider "aws" {
  region  = "eu-central-1"
  profile = "terraform"
}

terraform {
  backend "s3" {
    key = "prod/services/webserver-cluster/terraform.tfstate"
  }
}

module "webserver_cluster" {
  source                 = "../../../../modules/services/webserver-cluster"
  ami                    = "ami-0a86f18b52e547759"
  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "terraform-rastrigin-up-and-running"
  db_remote_state_key    = "prod/services/data-stores/terraform.tfstate"
  instance_type          = "t2.micro"
  min_size               = 1
  max_size               = 1
  enable_autoscaling     = false
  server_text            = "Hello Sergei v2!"

  custom_tags = {
    Owner      = "Sergei Rastrigin"
    DeployedBy = "terraform"
  }
}
