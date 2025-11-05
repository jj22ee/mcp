# Java Lambda Function Sample

This is a sample AWS Lambda function written in Java that demonstrates:

- API Gateway integration
- S3 service calls using AWS SDK for Java v2
- OpenTelemetry and X-Ray tracing support
- CloudWatch logging

## Prerequisites

- Java 17
- Maven 3.6+

## Building

```bash
mvn clean package
```

This creates `target/lambda-sample-1.0.0.jar` which can be deployed to AWS Lambda.

## Handler

The Lambda handler is: `com.example.Handler::handleRequest`

## Functionality

The function:
1. Lists S3 buckets in your account
2. Logs OpenTelemetry resource attributes
3. Logs X-Ray trace ID
4. Returns a response with bucket count and trace information