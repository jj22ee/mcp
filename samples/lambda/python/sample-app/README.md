# Python Lambda Function Sample

This is a sample AWS Lambda function written in Python that demonstrates:

- API Gateway integration
- S3 service calls using boto3
- OpenTelemetry and X-Ray tracing support
- CloudWatch logging

## Prerequisites

- Python 3.12
- pip

## Building

```bash
pip install -r requirements.txt -t .
zip -r function.zip . --exclude="*.pyc" "__pycache__/*"
```

This creates `function.zip` which can be deployed to AWS Lambda.

## Handler

The Lambda handler is: `lambda_function.lambda_handler`

## Functionality

The function:
1. Lists S3 buckets in your account
2. Logs OpenTelemetry resource attributes
3. Logs X-Ray trace ID
4. Returns a response with bucket count and trace information