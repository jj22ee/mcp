#!/bin/bash

# Get the current directory (should be lambda)
CDK_DIR=$(pwd)

cd "$CDK_DIR/node/cdk/"
./deploy.sh &

cd "$CDK_DIR/java/cdk/"
./deploy.sh &

cd "$CDK_DIR/python/cdk/"
./deploy.sh &

cd "$CDK_DIR/dotnet/cdk/"
./deploy.sh &

cd "$CDK_DIR/node/terraform/lambda/"
terraform init && terraform apply -auto-approve &

cd "$CDK_DIR/java/terraform/lambda/"
terraform init && terraform apply -auto-approve &

cd "$CDK_DIR/python/terraform/lambda/"
terraform init && terraform apply -auto-approve &

cd "$CDK_DIR/dotnet/terraform/lambda/"
terraform init && terraform apply -auto-approve &

wait

./show-urls.sh