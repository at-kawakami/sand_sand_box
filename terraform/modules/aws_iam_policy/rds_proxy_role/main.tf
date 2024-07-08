resource "aws_iam_policy" "rdsproxy_role" {
  description = null
  name        = var.name
  name_prefix = null
  path        = "/service-role/"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action   = ["secretsmanager:GetSecretValue","kms:Decrypt"]
      Effect   = "Allow"
      Resource = ["*"]
      Sid      = "ForRDSProxy"
      }]
  })
  #tags     = {}
  #tags_all = {}
}