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
