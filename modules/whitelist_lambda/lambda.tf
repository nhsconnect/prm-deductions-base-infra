variable "function_name" {
  default = "ip-whitelist-trigger"
}

variable "handler" {
  default = "lambda.handler"
}

variable "runtime" {
  default = "python3.7"
}

variable "subnet_id" {
  default = "subnet-08bda0473273f2671" # GoCD public subnet
}

data "aws_subnet" "gocd_subnet" {
  id = "${var.subnet_id}"
}

locals {
  vpc_id = data.aws_subnet.gocd_subnet.vpc_id
}

resource "aws_lambda_function" "lambda_function" {
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = var.handler
  runtime          = var.runtime
  filename         = "${path.module}/lambda.zip"
  source_code_hash = filesha256("${path.module}/lambda.zip")
  function_name    = var.function_name
  vpc_config {
    subnet_ids = [var.subnet_id]
    security_group_ids = [aws_security_group.whitelist-lambda.id]
  }
  depends_on = [
    aws_iam_role_policy_attachment.vpc-access-attach
  ]
}

resource "aws_iam_role" "lambda_exec_role" {
  name        = "lambda_exec"
  path        = "/"
  description = "Allows Lambda Function to call AWS services on your behalf."

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "vpc-access-attach" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}
