locals {
  architecture = var.architecture == "x86_64" ? "amd64" : "arm64"
}

module "hello-lambda-function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = ">= 2.24.0"

  architectures = compact([var.architecture])
  function_name = var.function_name
  handler       = "index.handler"
  runtime       = var.runtime

  create_package         = false
  local_existing_package = "${path.module}/../../sample-app/build/function.zip"

  memory_size = 512
  timeout     = 30

  environment_variables = {
  }

  tracing_mode = var.tracing_mode

  attach_policy_statements = true
  policy_statements = {
    s3 = {
      effect = "Allow"
      actions = [
        "s3:ListAllMyBuckets"
      ]
      resources = [
        "*"
      ]
    }
  }
}

module "api-gateway" {
  source = "../api-gateway-proxy"

  name                = var.function_name
  function_name       = module.hello-lambda-function.lambda_function_name
  function_invoke_arn = module.hello-lambda-function.lambda_function_invoke_arn
  enable_xray_tracing = var.tracing_mode == "Active"
}

resource "aws_iam_role_policy_attachment" "hello-lambda-cloudwatch" {
  role       = module.hello-lambda-function.lambda_function_name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "test_xray" {
  role       = module.hello-lambda-function.lambda_function_name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLambdaApplicationSignalsExecutionRolePolicy"
}
