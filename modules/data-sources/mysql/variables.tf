variable "db_password" {
  description = "password for mysql database"
  type = string
}

variable "instance_class" {
  type = string
  default = "db.t2.micro"
}

variable "prefix" {
  type = string
}

variable "username" {
  type = string
}

variable "name" {
  type = string
}


