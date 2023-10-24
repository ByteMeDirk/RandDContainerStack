#!/bin/bash

# Set CLOUD_SDK ENV to cloud_sdk variable found in dockerfile
cloud_sdk=$CLOUD_SDK
echo "CLOUD_SDK is set to $cloud_sdk"

# Raise error if cloud_sdk is not set
if [ -z "$cloud_sdk" ]; then
  echo "CLOUD_SDK is not set"
  exit 1
fi

if [ "$cloud_sdk" == "AWS" ]; then
  echo "Installing AWS cloud_sdk"
  # Install AWS cloud_sdk
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  ./aws/install
  # Remove awscliv2.zip and aws directory
  rm -rf awscliv2.zip aws
  # Install Python Dependencies
  pip install boto3
fi

if [ "$cloud_sdk" == "GCP" ]; then
  echo "Installing GCP cloud_sdk"
  # Install the Google Cloud SDK
  apt-get update
  apt-get install -y apt-transport-https ca-certificates gnupg
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
  apt-get update
  apt-get install -y google-cloud-sdk
  # Install Python Dependencies
  pip install google-cloud-storage google-cloud-bigquery google-cloud-bigquery-storage google-cloud-secret-manager google-cloud-pubsub google-cloud-logging
fi
