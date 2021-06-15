provider "aws" {
  region = "eu-central-1"
  profile = "terraform"
}

module "asg" {
  source = "../../modules/cluster/asg-rolling-deploy"

  cluster_name = var.cluster_name
  ami = "ami-0a86f18b52e547759"
  instance_type = "t2.micro"

  min_size = 1
  max_size = 1
  enable_autoscaling = false
  subnet_ids = data.aws_subnet_ids.default.ids
  user_data = <<EOF
  #!/bin/bash
echo "Hello, World" >> index.html
nohup busybox httpd -f -p 8888 &
EOF
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}
