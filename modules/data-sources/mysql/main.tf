resource "aws_db_instance" "example" {
  identifier_prefix = var.prefix
  engine = "mysql"
  allocated_storage = 10
  instance_class = var.instance_class
  name = var.name
  username = var.username
  skip_final_snapshot = true
  password = var.db_password
}
