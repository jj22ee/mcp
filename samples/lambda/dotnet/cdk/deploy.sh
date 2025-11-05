#!/bin/bash

# Build the .NET Lambda function
cd ../sample-app
dotnet publish -c Release -o bin/Release/net8.0/publish
cd bin/Release/net8.0/publish
zip -r function.zip .

# Deploy with CDK
cd ../../../../cdk
npm install
npm run build
npm run deploy