output "aws_db_instance" {
  value = aws_db_instance.main.id
  }

output "master_user_secret" {
  value = aws_db_instance.main.master_user_secret
}