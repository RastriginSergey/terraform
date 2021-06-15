provider "aws" {
  region  = "eu-central-1"
  profile = "terraform"
}

terraform {
  backend "s3" {
    key = "stage/services/webserver-cluster/terraform.tfstate"
  }
}

module "webserver_cluster" {
  source                 = "github.com/RastriginSergey/terraform-modules//webserver-cluster"
  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "terraform-rastrigin-up-and-running"
  db_remote_state_key    = "stage/services/webserver-cluster/terraform.tfstate"
  instance_type          = "t2.micro"
  min_size               = 2
  max_size               = 2
  enable_autoscaling     = false
  enable_new_user_data   = true
}

resource "aws_security_group_rule" "allow_testing_inbound" {
  type              = "ingress"
  security_group_id = module.webserver_cluster.alb_security_group_id

  from_port   = 12345
  to_port     = 12345
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
