#!/bin/bash
#
# Deploy to S3 bucket and create invalidation

assets_path=$1
s3_bucket=$2
optional_cloudfront_id=$3

echo "Synchronizing files..."
aws s3 sync ${assets_path} s3://${s3_bucket} --size-only --delete
echo "...done"

if [ ${optional_cloudfront_id} ]
then
    echo "Triggering cache invalidation"
    aws cloudfront create-invalidation --distribution-id ${optional_cloudfront_id} --paths "/*"
    echo "...done"
else
    echo "Skipping cache invalidation"
fi
