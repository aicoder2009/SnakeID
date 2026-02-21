#!/bin/bash

# Ensure OPENAI_API_KEY is set in the environment (do NOT hardcode it here)
if [ -z "$OPENAI_API_KEY" ]; then
  echo "Error: OPENAI_API_KEY environment variable is not set."
  echo "Export it before running this script: export OPENAI_API_KEY=your-key"
  exit 1
fi

# Create deployment package
cd lambda
python3 -m pip install -r requirements.txt -t .
zip -r ../snake-identifier-lambda.zip .
cd ..

# Update Lambda function
aws lambda update-function-code \
  --function-name snake-identifier \
  --zip-file fileb://snake-identifier-lambda.zip

# Update environment variables
aws lambda update-function-configuration \
  --function-name snake-identifier \
  --environment Variables="{OPENAI_API_KEY=$OPENAI_API_KEY}"

echo "Lambda updated successfully!"
