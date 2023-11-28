#!/bin/bash

echo "Enter your name and first letter of your last name in lowercase, no spaces, exactly as in lab2. Example: johnd"
read USER_NAME

RESOURCE_GROUP_NAME="${USER_NAME}-tfstate"

echo "Enter your STORAGE_ACCOUNT_NAME as in lab2. Example: johndtfstate00000"
read STORAGE_ACCOUNT_NAME


echo "________________________________________________________________"
echo "Setting up local .auto.tfvars:"
cat << EOF > .auto.tfvars
prefix = "${USER_NAME}lab3"
EOF

echo "________________________________________________________________"
echo "Setting up backend.hcl"
cat << EOF > backend.hcl
container_name       = "tfstate"
key                  = "lab3.tfstate"
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
