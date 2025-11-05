# Node.js Lambda Function Sample

This is a sample AWS Lambda function written in TypeScript that demonstrates:

- API Gateway integration
- S3 service calls using AWS SDK for JavaScript v3
- OpenTelemetry and X-Ray tracing support
- CloudWatch logging

## Prerequisites

- Node.js 20
- npm

## Building

```bash
npm install
npm run compile
```

This creates `build/function.zip` which can be deployed to AWS Lambda.

## Handler

The Lambda handler is: `index.handler`

## Functionality

The function:
1. Lists S3 buckets in your account
2. Logs OpenTelemetry resource attributes
3. Logs X-Ray trace ID
4. Returns a response with bucket count and trace information