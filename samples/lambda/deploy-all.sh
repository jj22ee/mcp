#!/bin/bash

# Get the current directory (should be lambda)
CDK_DIR=$(pwd)

# Bootstrap account
npm install -g aws-cdk
npx cdk bootstrap aws://$(aws sts get-caller-identity --query Account --output text)/$(aws configure get region)

# Builds sample apps (pre-requisite for deployment via terraform), then deploy via CDK
cd "$CDK_DIR/node/cdk/"
./deploy.sh &

cd "$CDK_DIR/java/cdk/"
./deploy.sh &

cd "$CDK_DIR/python/cdk/"
./deploy.sh &

cd "$CDK_DIR/dotnet/cdk/"
./deploy.sh &

wait

# Deploy via terraform
cd "$CDK_DIR/node/terraform/lambda/"
terraform init && terraform apply -auto-approve &

cd "$CDK_DIR/java/terraform/lambda/"
terraform init && terraform apply -auto-approve &

cd "$CDK_DIR/python/terraform/lambda/"
terraform init && terraform apply -auto-approve &

cd "$CDK_DIR/dotnet/terraform/lambda/"
terraform init && terraform apply -auto-approve &

wait

cd "$CDK_DIR/"
./show-urls.sh
