output "rds_rdsproxy" {
  value = aws_security_group.rds_rdsproxy.id
}
output "lambda_using_rdsproxy" {
  value = aws_security_group.lambda_using_rdsproxy.id
}
output "rdsproxy_lambda" {
  value = aws_security_group.rdsproxy_lambda.id
}