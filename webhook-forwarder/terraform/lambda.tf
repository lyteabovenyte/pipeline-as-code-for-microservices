resource "aws_lambda_function" "lambda" {
  filename      = "../deployment.zip" # packaging index.js entrypoint for the lambda function.
  function_name = "GitHubWebhookForwarder"
  role          = aws_iam_role.role.arn
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  timeout       = 10
  environment {
    variables = {
      JENKINS_URL = var.jenkins_url
    }
  }
}