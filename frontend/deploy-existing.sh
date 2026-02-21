#!/bin/bash

# Quick deployment to existing S3 bucket
# Set these via environment variables or a .env file
BUCKET_NAME="${S3_BUCKET_NAME:?Error: S3_BUCKET_NAME environment variable is not set.}"
DISTRIBUTION_ID="${CLOUDFRONT_DISTRIBUTION_ID:?Error: CLOUDFRONT_DISTRIBUTION_ID environment variable is not set.}"

# Build the app
npm run build

# Upload files to existing bucket
aws s3 sync out/ s3://$BUCKET_NAME --delete

# Invalidate CloudFront cache
aws cloudfront create-invalidation --distribution-id $DISTRIBUTION_ID --paths "/*"

echo "Deployed to existing bucket: $BUCKET_NAME"
echo "Cache invalidation initiated"
