#!/bin/bash

# configure project
PROJECT_NAME=$1
if [ -z "$PROJECT_NAME" ]; then
    echo "Usage: $0 <project_name>"
    exit 1
fi

if [ ! -d "$PROJECT_NAME" ]; then
    echo "Project: $PROJECT_NAME does not exist."
    exit 1
fi

# Configure actions
ACTION=$2
if [ -z "$ACTION" ]; then
    echo "Usage: $0 <project_name> <up|down>"
    exit 1
fi

if [ "$ACTION" != "up" ] && [ "$ACTION" != "down" ]; then
    echo "Invalid action: $ACTION. Use 'up' or 'down'."
    exit 1
fi

# Set project environment
cd $PROJECT_NAME
TFVARS=$( for a in *.tfvars ; do echo -var-file=$a ; done )

# echo $TFVARS && exit 

# Terraform init
terraform init
if [ $? -ne 0 ]; then
    echo "Terraform init failed."
    exit 1
fi

# Terraform validate
terraform validate
if [ $? -ne 0 ]; then
    echo "Terraform validate failed."
    exit 1
fi

# Terraform format
terraform fmt -check
if [ $? -ne 0 ]; then
    echo "Terraform format check failed."
    exit 1
fi

if [ "$ACTION" == "down" ]; then
    terraform destroy $TFVARS -auto-approve
    if [ $? -ne 0 ]; then
        echo "Terraform destroy failed."
        exit 1
    fi
    echo "Environment $PROJECT_NAME destroyed successfully."
    exit 0
fi

# Terraform plan and apply
if [ "$ACTION" == "up" ]; then
    terraform plan $TFVARS -out=tfplan
    if [ $? -ne 0 ]; then
        echo "Terraform plan failed."
        exit 1
    fi

    terraform apply $TFVARS tfplan
    if [ $? -ne 0 ]; then
        echo "Terraform apply failed."
        exit 1
    fi
fi