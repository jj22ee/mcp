#!/bin/bash

# Get the current directory (should be lambda)
CDK_DIR=$(pwd)

echo "=== API Gateway URLs ==="

# CDK outputs
if [ -f "$CDK_DIR/node/cdk/outputs.json" ]; then
  echo -n "Node.js CDK: "
  grep -o 'https://[^"]*' "$CDK_DIR/node/cdk/outputs.json" | head -1
fi

if [ -f "$CDK_DIR/java/cdk/outputs.json" ]; then
  echo -n "Java CDK: "
  grep -o 'https://[^"]*' "$CDK_DIR/java/cdk/outputs.json" | head -1
fi

if [ -f "$CDK_DIR/python/cdk/outputs.json" ]; then
  echo -n "Python CDK: "
  grep -o 'https://[^"]*' "$CDK_DIR/python/cdk/outputs.json" | head -1
fi

if [ -f "$CDK_DIR/dotnet/cdk/outputs.json" ]; then
  echo -n ".NET CDK: "
  grep -o 'https://[^"]*' "$CDK_DIR/dotnet/cdk/outputs.json" | head -1
fi

# Terraform outputs
echo -n "Node.js Terraform: "
cd "$CDK_DIR/node/terraform/lambda/" && terraform output -raw api-gateway-url 2>/dev/null
echo

echo -n "Java Terraform: "
cd "$CDK_DIR/java/terraform/lambda/" && terraform output -raw api-gateway-url 2>/dev/null
echo

echo -n "Python Terraform: "
cd "$CDK_DIR/python/terraform/lambda/" && terraform output -raw api-gateway-url 2>/dev/null
echo

echo -n ".NET Terraform: "
cd "$CDK_DIR/dotnet/terraform/lambda/" && terraform output -raw api-gateway-url 2>/dev/null
echo