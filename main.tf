data "aws_caller_identity" "apps_account" {
  provider = aws.apps_account
}

data "aws_region" "apps_account" {
  provider = aws.apps_account
}

data "aws_caller_identity" "data_account" {
  provider = aws.data_account
}
