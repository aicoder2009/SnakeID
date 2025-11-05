#!/bin/bash
set -e

echo "🐍 SnakeID AWS Deployment Script"
echo "=================================="

# Load environment variables from .env file
if [ -f .env ]; then
    echo "✓ Loading environment variables from .env file"
    export $(cat .env | grep -v '^#' | xargs)
else
    echo "❌ Error: .env file not found"
    echo "Please create a .env file with your AWS credentials"
    exit 1
fi

# Verify required variables
if [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
    echo "❌ Error: Required environment variables not set"
    echo "Please ensure .env contains AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY"
    exit 1
fi

# Configure AWS CLI
export AWS_DEFAULT_REGION=${AWS_REGION:-us-east-1}
echo "✓ Using AWS Region: $AWS_DEFAULT_REGION"

# Generate unique bucket name
TIMESTAMP=$(date +%s)
BUCKET_NAME="${S3_BUCKET_PREFIX:-snake-identifier-pwa}-${TIMESTAMP}"

echo ""
echo "📦 Step 1: Creating and deploying Lambda function"
echo "=================================================="

# Create Lambda execution role if it doesn't exist
ROLE_NAME="snake-identifier-lambda-role"
echo "Checking if IAM role exists..."

if ! aws iam get-role --role-name $ROLE_NAME 2>/dev/null; then
    echo "Creating IAM role for Lambda..."

    # Create trust policy
    cat > /tmp/trust-policy.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

    aws iam create-role \
        --role-name $ROLE_NAME \
        --assume-role-policy-document file:///tmp/trust-policy.json

    # Attach basic execution policy
    aws iam attach-role-policy \
        --role-name $ROLE_NAME \
        --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

    # Create and attach Bedrock invoke policy
    cat > /tmp/bedrock-policy.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "bedrock:InvokeModel",
        "bedrock:InvokeModelWithResponseStream"
      ],
      "Resource": "*"
    }
  ]
}
EOF

    aws iam put-role-policy \
        --role-name $ROLE_NAME \
        --policy-name BedrockInvokePolicy \
        --policy-document file:///tmp/bedrock-policy.json

    echo "Waiting 10 seconds for IAM role to propagate..."
    sleep 10
else
    echo "✓ IAM role already exists"
fi

ROLE_ARN=$(aws iam get-role --role-name $ROLE_NAME --query 'Role.Arn' --output text)
echo "✓ Using role: $ROLE_ARN"

# Package Lambda function
echo "Packaging Lambda function..."
cd backend/lambda

# Install dependencies
python3 -m pip install -r requirements.txt -t . --upgrade

# Create deployment package
zip -r ../snake-identifier-lambda.zip . -x "*.pyc" "__pycache__/*"
cd ../..

# Check if Lambda function exists
echo "Checking if Lambda function exists..."
if aws lambda get-function --function-name ${LAMBDA_FUNCTION_NAME} 2>/dev/null; then
    echo "Updating existing Lambda function..."
    aws lambda update-function-code \
        --function-name ${LAMBDA_FUNCTION_NAME} \
        --zip-file fileb://backend/snake-identifier-lambda.zip

    aws lambda update-function-configuration \
        --function-name ${LAMBDA_FUNCTION_NAME} \
        --environment Variables="{AWS_REGION=$AWS_DEFAULT_REGION}"
else
    echo "Creating new Lambda function..."
    aws lambda create-function \
        --function-name ${LAMBDA_FUNCTION_NAME} \
        --runtime python3.11 \
        --role $ROLE_ARN \
        --handler lambda_function.lambda_handler \
        --zip-file fileb://backend/snake-identifier-lambda.zip \
        --timeout 30 \
        --memory-size 512 \
        --environment Variables="{AWS_REGION=$AWS_DEFAULT_REGION}"

    echo "Waiting for Lambda function to be ready..."
    sleep 5
fi

# Create or get Function URL
echo "Setting up Lambda Function URL..."
FUNCTION_URL=$(aws lambda list-function-url-configs --function-name ${LAMBDA_FUNCTION_NAME} --query 'FunctionUrlConfigs[0].FunctionUrl' --output text 2>/dev/null || echo "None")

if [ "$FUNCTION_URL" == "None" ]; then
    echo "Creating Function URL..."
    FUNCTION_URL=$(aws lambda create-function-url-config \
        --function-name ${LAMBDA_FUNCTION_NAME} \
        --auth-type NONE \
        --cors AllowOrigins='*',AllowMethods='POST,OPTIONS',AllowHeaders='Content-Type' \
        --query 'FunctionUrl' --output text)

    # Add permission for public access
    aws lambda add-permission \
        --function-name ${LAMBDA_FUNCTION_NAME} \
        --statement-id FunctionURLAllowPublicAccess \
        --action lambda:InvokeFunctionUrl \
        --principal "*" \
        --function-url-auth-type NONE 2>/dev/null || true
fi

echo "✓ Lambda Function URL: $FUNCTION_URL"

echo ""
echo "🌐 Step 2: Building and deploying frontend"
echo "==========================================="

cd frontend

# Update the Lambda URL in the frontend code
echo "Updating Lambda Function URL in frontend..."
if [ -f pages/index.tsx ]; then
    # Use a temporary file for the replacement
    sed "s|https://[^/]*\.lambda-url\.[^/]*\.on\.aws/|${FUNCTION_URL}|g" pages/index.tsx > pages/index.tsx.tmp
    mv pages/index.tsx.tmp pages/index.tsx
    echo "✓ Frontend updated with new Lambda URL"
fi

# Install dependencies and build
echo "Installing frontend dependencies..."
npm install

echo "Building Next.js application..."
npm run build

# Create S3 bucket
echo "Creating S3 bucket: $BUCKET_NAME"
aws s3 mb s3://$BUCKET_NAME --region $AWS_DEFAULT_REGION

# Configure bucket for static website hosting
echo "Configuring bucket for static website hosting..."
aws s3 website s3://$BUCKET_NAME --index-document index.html --error-document index.html

# Upload files
echo "Uploading files to S3..."
aws s3 sync out/ s3://$BUCKET_NAME --delete

# Make bucket public
echo "Configuring public access..."
aws s3api delete-public-access-block --bucket $BUCKET_NAME 2>/dev/null || true

cat > /tmp/bucket-policy.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${BUCKET_NAME}/*"
    }
  ]
}
EOF

aws s3api put-bucket-policy --bucket $BUCKET_NAME --policy file:///tmp/bucket-policy.json

echo "✓ S3 bucket deployed successfully"

# Create CloudFront distribution
echo ""
echo "☁️  Step 3: Creating CloudFront distribution"
echo "==========================================="

cat > /tmp/cf-config.json <<EOF
{
  "CallerReference": "${TIMESTAMP}",
  "DefaultRootObject": "index.html",
  "Origins": {
    "Quantity": 1,
    "Items": [
      {
        "Id": "S3Origin",
        "DomainName": "${BUCKET_NAME}.s3-website-${AWS_DEFAULT_REGION}.amazonaws.com",
        "CustomOriginConfig": {
          "HTTPPort": 80,
          "HTTPSPort": 443,
          "OriginProtocolPolicy": "http-only"
        }
      }
    ]
  },
  "DefaultCacheBehavior": {
    "TargetOriginId": "S3Origin",
    "ViewerProtocolPolicy": "redirect-to-https",
    "TrustedSigners": {
      "Enabled": false,
      "Quantity": 0
    },
    "ForwardedValues": {
      "QueryString": false,
      "Cookies": {"Forward": "none"}
    },
    "MinTTL": 0,
    "Compress": true,
    "AllowedMethods": {
      "Quantity": 2,
      "Items": ["GET", "HEAD"],
      "CachedMethods": {
        "Quantity": 2,
        "Items": ["GET", "HEAD"]
      }
    }
  },
  "Comment": "Snake Identifier PWA Distribution",
  "Enabled": true,
  "CustomErrorResponses": {
    "Quantity": 1,
    "Items": [
      {
        "ErrorCode": 404,
        "ResponsePagePath": "/index.html",
        "ResponseCode": "200",
        "ErrorCachingMinTTL": 300
      }
    ]
  }
}
EOF

echo "Creating CloudFront distribution (this may take a few minutes)..."
DISTRIBUTION_OUTPUT=$(aws cloudfront create-distribution --distribution-config file:///tmp/cf-config.json)
DISTRIBUTION_ID=$(echo $DISTRIBUTION_OUTPUT | grep -o '"Id": "[^"]*"' | head -1 | cut -d'"' -f4)
CLOUDFRONT_URL=$(echo $DISTRIBUTION_OUTPUT | grep -o '"DomainName": "[^"]*"' | head -1 | cut -d'"' -f4)

cd ..

echo ""
echo "✅ Deployment Complete!"
echo "======================="
echo ""
echo "📝 Deployment Details:"
echo "  Lambda Function: ${LAMBDA_FUNCTION_NAME}"
echo "  Lambda URL: ${FUNCTION_URL}"
echo "  S3 Bucket: ${BUCKET_NAME}"
echo "  S3 Website: http://${BUCKET_NAME}.s3-website-${AWS_DEFAULT_REGION}.amazonaws.com"
echo "  CloudFront URL: https://${CLOUDFRONT_URL}"
echo "  CloudFront Distribution ID: ${DISTRIBUTION_ID}"
echo ""
echo "⚠️  Note: CloudFront distribution takes 10-15 minutes to fully deploy"
echo "   You can check status with: aws cloudfront get-distribution --id ${DISTRIBUTION_ID}"
echo ""
echo "🔗 Access your app at: https://${CLOUDFRONT_URL}"
echo ""

# Save deployment info
cat > deployment-info.txt <<EOF
SnakeID Deployment Information
Generated: $(date)

Lambda Function: ${LAMBDA_FUNCTION_NAME}
Lambda URL: ${FUNCTION_URL}
S3 Bucket: ${BUCKET_NAME}
S3 Website: http://${BUCKET_NAME}.s3-website-${AWS_DEFAULT_REGION}.amazonaws.com
CloudFront URL: https://${CLOUDFRONT_URL}
CloudFront Distribution ID: ${DISTRIBUTION_ID}
AWS Region: ${AWS_DEFAULT_REGION}

Next Steps:
1. Wait 10-15 minutes for CloudFront to fully deploy
2. Access your app at: https://${CLOUDFRONT_URL}
3. Test the snake identification feature
4. Consider setting up a custom domain

Updating the deployment:
- Frontend: cd frontend && npm run build && aws s3 sync out/ s3://${BUCKET_NAME} --delete
- Lambda: cd backend && ./deploy-lambda.sh
- CloudFront cache: aws cloudfront create-invalidation --distribution-id ${DISTRIBUTION_ID} --paths "/*"
EOF

echo "📄 Deployment info saved to deployment-info.txt"
