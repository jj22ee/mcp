# .NET Lambda Function Sample

This is a sample AWS Lambda function written in C# that demonstrates:

- API Gateway integration
- S3 service calls using AWS SDK for .NET
- OpenTelemetry and X-Ray tracing support
- CloudWatch logging

## Prerequisites

- .NET 8 SDK
- AWS CLI configured

## Building

```bash
dotnet publish -c Release -o bin/Release/net8.0/publish
cd bin/Release/net8.0/publish
zip -r function.zip .
```

This creates `function.zip` which can be deployed to AWS Lambda.

## Handler

The Lambda handler is: `LambdaSample::LambdaSample.Function::FunctionHandler`

## Functionality

The function:
1. Lists S3 buckets in your account
2. Logs OpenTelemetry resource attributes
3. Logs X-Ray trace ID
4. Returns a response with bucket count and trace information