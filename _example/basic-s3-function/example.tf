provider "aws" {
  region = "us-west-2"
}

locals {
  name        = "lambda1"
  environment = "test1"
}

##-----------------------------------------------------------------------------
## lambda Module Call with s3_bucket.
##-----------------------------------------------------------------------------
module "lambda" {
  source      = "../../"
  name        = local.name
  environment = local.environment

  s3_bucket = "roshan-7665"
  s3_key    = "index.zip"

  handler = "index.handler"
  runtime = "nodejs18.x"

  # CONCURRENCY FIX: Yeh line add karein ya confirm karein value 0/null hai
  reserved_concurrent_executions = 0 # <-- YEH IMPORTANT LINE ADD KAREIN

  iam_actions = [
    "logs:CreateLogStream",
    "logs:CreateLogGroup",
    "logs:PutLogEvents"
  ]

  variables = {
    foo = "bar"
  }

  # Ensure yeh important variables set hain:
  create_iam_role               = true
  attach_cloudwatch_logs_policy = true
  enable_kms                    = true
}