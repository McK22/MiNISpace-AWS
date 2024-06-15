#!/bin/bash

usage() {
  echo "Usage: $0 <file_path> <bucket_name> [<s3_key>]"
  echo "  <file_path>  : Path to the file you want to upload."
  echo "  <bucket_name>: Name of the S3 bucket."
  echo "  [<s3_key>]   : (Optional) S3 key (path) where the file will be stored. Defaults to the filename."
  exit 1
}

if [ "$#" -lt 2 ]; then
  usage
fi

FILE_PATH=$1
BUCKET_NAME=$2
S3_KEY=${3:-$(basename "$FILE_PATH")}

if [ ! -f "$FILE_PATH" ]; then
  echo "Error: File '$FILE_PATH' not found."
  exit 1
fi

echo "Uploading '$FILE_PATH' to 's3://$BUCKET_NAME/$S3_KEY'..."
aws s3 cp "$FILE_PATH" "s3://$BUCKET_NAME/$S3_KEY"

if [ $? -eq 0 ]; then
  echo "File uploaded successfully."
else
  echo "Error: File upload failed."
  exit 1
fi

