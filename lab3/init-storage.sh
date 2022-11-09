#!/bin/bash

# Enter your name
FIRST_NAME=

RESOURCE_GROUP_NAME="${FIRST_NAME:?You have not entered your first name}-tfstate"
STORAGE_ACCOUNT_NAME="${FIRST_NAME}tfstate${RANDOM}"
CONTAINER_NAME=tfstate
LOCATION=westeurope

# Create resource group
az group create \
  --name "${RESOURCE_GROUP_NAME}" \
  --location "${LOCATION}"

# Create storage account
az storage account create \
    --resource-group "${RESOURCE_GROUP_NAME}" \
    --name "${STORAGE_ACCOUNT_NAME}" \
    --sku Standard_LRS \
    --encryption-services blob

#Enable versioning
az storage account blob-service-properties update \
    --resource-group "${RESOURCE_GROUP_NAME}" \
    --account-name "${STORAGE_ACCOUNT_NAME}" \
    --enable-versioning true

# Create blob container
az storage container create \
  --name "${CONTAINER_NAME}" \
  --account-name "${STORAGE_ACCOUNT_NAME}"

cat << EOF > auto.tfvars
prefix = "${FIRST_NAME}"
EOF

echo "RESOURCE_GROUP_NAME:  \"${RESOURCE_GROUP_NAME}\""
echo "STORAGE_ACCOUNT_NAME: \"${STORAGE_ACCOUNT_NAME}\""
