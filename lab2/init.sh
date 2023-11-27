#!/bin/bash

echo "Enter your name and first letter of your last name in lowercase, no spaces. Example: johnd"
read USER_NAME

echo "________________________________________________________________"
echo "Setting local variables"
RESOURCE_GROUP_NAME="${USER_NAME:?You have not entered your name}-tfstate"
STORAGE_ACCOUNT_NAME="${USER_NAME}tfstate${RANDOM}"
CONTAINER_NAME=tfstate
LOCATION=westeurope

echo "________________________________________________________________"
echo "Creating resource group:"
az group create \
  --name "${RESOURCE_GROUP_NAME}" \
  --location "${LOCATION}"

echo "________________________________________________________________"
echo "Creating storage account:"
az storage account create \
    --resource-group "${RESOURCE_GROUP_NAME}" \
    --name "${STORAGE_ACCOUNT_NAME}" \
    --sku Standard_LRS \
    --encryption-services blob

echo "________________________________________________________________"
echo "Enabling versioning:"
az storage account blob-service-properties update \
    --resource-group "${RESOURCE_GROUP_NAME}" \
    --account-name "${STORAGE_ACCOUNT_NAME}" \
    --enable-versioning true

echo "________________________________________________________________"
echo "Creating blob container:"
az storage container create \
  --name "${CONTAINER_NAME}" \
  --account-name "${STORAGE_ACCOUNT_NAME}"

echo "________________________________________________________________"
echo "Setting up local .auto.tfvars:"
cat << EOF > .auto.tfvars
prefix = "${USER_NAME}lab2"
EOF

echo "________________________________________________________________"
echo "Setting up backend.hcl"
cat << EOF > backend.hcl
container_name       = "tfstate"
key                  = "lab2.tfstate"
resource_group_name  = "${RESOURCE_GROUP_NAME}"
storage_account_name = "${STORAGE_ACCOUNT_NAME}"
EOF

echo "________________________________________________________________"
echo "Provisioning complete. You can proceed with the next steps:"
echo "1. Inspect all created files"
echo "2. Initialize terraform with the creatend \"backend.hcl\" config: terraform init -backend-config=backend.hcl"
echo "3. Create and store the terraform plan"
echo "4. Inspect the created plan"
echo "5. Apply the plan"
echo "6. Verify the created resources on Azure portal"
echo "7. Inspect the terraform state in the provisioned bucket"
echo "8. Happy terraforming!"
