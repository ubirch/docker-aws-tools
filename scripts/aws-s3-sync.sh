#!/bin/bash -x

# this scripts sync a local directory with an AWS S3 bucket.
# input local directory, AWS CREDENTIALS, S3 bucket

AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID:-zero}
AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY:-zero}


echo "AWS_ACCESS_KEY_ID: ${AWS_ACCESS_KEY_ID}"
echo "AWS_SECRET_ACCESS_KEY: ${AWS_SECRET_ACCESS_KEY}"

if [ "${AWS_SECRET_ACCESS_KEY}" == "zero" ]; then
  echo "You must specify AWS_SECRET_ACCESS_KEY as environment variable"
  exit 1
fi

if [ "${AWS_ACCESS_KEY_ID}" == "zero" ]; then
  echo "You must specify AWS_ACCESS_KEY_ID as environment variable"
  exit 1
fi

aws s3 sync /build $1 --dryrun --exclude ".git*" --delete
