output "address" {
    value = aws_db_instance.example.address
    description = "connect to the database using this address"
}

output "port" {
    value = aws_db_instance.example.port
    description = "database port"
}