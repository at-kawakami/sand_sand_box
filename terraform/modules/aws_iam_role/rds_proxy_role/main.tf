resource "aws_iam_role" "rds_proxy_role" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "rds.amazonaws.com"
      }
    }]
    #Version = "2012-10-17"
  })
  description           = "Allows RDS Proxy access to database connection credentials"
  force_detach_policies = false
  #managed_policy_arns   = ["arn:aws:iam::571429965935:policy/service-role/rds-proxy-policy-1720075954820"]
  managed_policy_arns   = [var.aws_iam_policy.arn]
  max_session_duration  = 3600
  name                  = var.name
  name_prefix           = null
  path                  = "/service-role/"
  permissions_boundary  = null
  #tags                  = {}
  #tags_all              = {}
}