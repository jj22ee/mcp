#!/bin/bash

# Get the current directory (should be lambda)
CDK_DIR=$(pwd)

echo ""
echo "=== API Gateway URLs ==="
echo ""

# CDK outputs
echo "Node.js CDK:"
if [ -f "$CDK_DIR/node/cdk/outputs.json" ]; then
  grep -o 'https://[^"]*' "$CDK_DIR/node/cdk/outputs.json" | head -1
fi
echo ""

echo "Java CDK:"
if [ -f "$CDK_DIR/java/cdk/outputs.json" ]; then
  grep -o 'https://[^"]*' "$CDK_DIR/java/cdk/outputs.json" | head -1
fi
echo ""

echo "Python CDK:"
if [ -f "$CDK_DIR/python/cdk/outputs.json" ]; then
  grep -o 'https://[^"]*' "$CDK_DIR/python/cdk/outputs.json" | head -1
fi
echo ""

echo ".NET CDK:"
if [ -f "$CDK_DIR/dotnet/cdk/outputs.json" ]; then
  grep -o 'https://[^"]*' "$CDK_DIR/dotnet/cdk/outputs.json" | head -1
fi
echo ""

# Terraform outputs
echo "Node.js Terraform:"
cd "$CDK_DIR/node/terraform/lambda/" && terraform output -raw api-gateway-url 2>/dev/null
echo ""

echo "Java Terraform:"
cd "$CDK_DIR/java/terraform/lambda/" && terraform output -raw api-gateway-url 2>/dev/null
echo ""

echo "Python Terraform:"
cd "$CDK_DIR/python/terraform/lambda/" && terraform output -raw api-gateway-url 2>/dev/null
echo ""

echo ".NET Terraform:"
cd "$CDK_DIR/dotnet/terraform/lambda/" && terraform output -raw api-gateway-url 2>/dev/null
echo ""