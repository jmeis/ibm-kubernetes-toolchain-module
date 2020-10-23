#!/usr/bin/env bash

# Doc: https://github.com/open-toolchain/sdk/wiki/Toolchain-Creation-page-parameters#headless-toolchain-creation-and-update

# Required env vars/input values:
# IAM_TOKEN - IAM token
# REGION - toolchain region
# REPOSITORY - template repository
# BRANCH - template repository branch
# API_KEY - api key for deploying app to IBM Cloud
# RESOURCE_GROUP_ID - resource group ID for the toolchain

# Optional env vars/input values:
# ADDITIONAL_PARAMETERS - additional URL parameters

set -x

curl -i -v -X POST \
  -H 'Accept: application/json' \
  -H "Authorization: ${IAM_TOKEN}" \
  -d "apiKey=${API_KEY}" \
  -d "autocreate=true" \
  -d "branch=${BRANCH}" \
  -d "env_id=ibm:yp:${REGION}" \
  -d "repository=${REPOSITORY}" \
  -d "resourceGroupId=${RESOURCE_GROUP_ID}" \
  -d "${ADDITIONAL_PARAMETERS}" \
  "https://cloud.ibm.com/devops/setup/deploy"
