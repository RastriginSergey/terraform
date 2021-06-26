variable "db_remote_state_bucket" {
  description = "The name of the s3 bucket for the database's remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "The path for the database's remote state in s3"
  type        = string
}

variable "server_text" {
  type    = string
  default = "Hello World!"
}

variable "environment" {
  type = string
  description = "The name of the environment we're deploying to"
}

variable "cluster_name" {
  description = "name to use for all the cluster resources"
  type        = string
}

variable "ami" {
  description = "the ami to be used for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instances to run"
  type        = string
}

variable "min_size" {
  description = "Minimum amount of ec2 instances in ASG"
  type        = number
}

variable "max_size" {
  description = "Minimum amount of ec2 instances in ASG"
  type        = number
}

variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG"
  type        = map(string)
  default     = {}
}

variable "enable_autoscaling" {
  description = "if set to true, enable auto scaling"
  type        = bool
}

variable "server_port" {
  type    = number
  default = 8080
}

variable "subnet_ids" {
  type = list(string)
  description = "The subnet IDs to deploy to"
}

variable "target_group_arns" {
  type = list(string)
  description = "The ARNs of ELB target groups in which to register Instances"
  default = []
}

variable "health_check_type" {
  type = string
  description = "The type of health check to perform. Must be one of: EC2, ELB"
  default = "EC2"
}

variable "user_data" {
  type = string
  description = "The User Data script to run in each Instance at boot"
  default = ""
}

