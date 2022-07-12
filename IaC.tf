
resource "aws_s3_bucket" "nice-devops-interview-moshe" {

  bucket = "nice-devops-interview-moshe"

  tags = {
    Name        = "nice-devops-interview-moshe"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.nice-devops-interview-moshe.id
  acl    = "private"
}



resource "aws_iam_role" "iam_for_lambda" {
  name = "lambda-execution-devops-interview"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "lambda-nice-devops-interview-moshe" {

  filename      = "lambda-nice-devops-interview-moshe/lambda-nice-devops-interview-moshe.zip"
  function_name = "lambda-nice-devops-interview-moshe"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.get_string_from_github_file"

  source_code_hash = filebase64sha256("lambda-nice-devops-interview-moshe/lambda-nice-devops-interview-moshe.zip")

  runtime = "python3.8"

}

