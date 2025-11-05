#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from 'aws-cdk-lib';
import { LambdaApiGatewayStack } from '../lib/lambda-apigateway-stack';

const app = new cdk.App();

const functionName = app.node.tryGetContext('functionName') || `aws-opentelemetry-distro-java-${Math.random().toString(36).substring(2, 10)}`;
const runtime = app.node.tryGetContext('runtime') || 'java17';
const architecture = app.node.tryGetContext('architecture') || 'x86_64';
const tracingMode = app.node.tryGetContext('tracingMode') || 'Active';

new LambdaApiGatewayStack(app, 'LambdaApiGatewayStack-CDK-ADOT-java', {
  functionName,
  runtime,
  architecture,
  tracingMode,
  env: {
    account: process.env.CDK_DEFAULT_ACCOUNT,
    region: process.env.CDK_DEFAULT_REGION,
  },
});