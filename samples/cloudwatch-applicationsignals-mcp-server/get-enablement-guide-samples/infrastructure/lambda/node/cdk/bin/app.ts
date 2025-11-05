#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from 'aws-cdk-lib';
import { LambdaApiGatewayStack } from '../lib/lambda-apigateway-stack';

const app = new cdk.App();

const functionName = app.node.tryGetContext('functionName') || `aws-opentelemetry-distro-nodejs-cdk-${Math.random().toString(36).substring(2, 10)}`;
const runtime = app.node.tryGetContext('runtime') || 'nodejs20.x';
const architecture = app.node.tryGetContext('architecture') || 'x86_64';

new LambdaApiGatewayStack(app, 'LambdaApiGatewayStack-CDK-ADOT-nodejs', {
  functionName,
  runtime,
  architecture,
  env: {
    account: process.env.CDK_DEFAULT_ACCOUNT,
    region: process.env.CDK_DEFAULT_REGION,
  },
});