# brisa-network
<b>brisa-network</b> is a Terraform-based project designed to provision AWS Virtual Private Clouds (VPCs) for experimentation, testing, and skill development in cloud infrastructure. It facilitates the creation of isolated networking environments across multiple AWS regions and environments (e.g., development, staging, production).

## 📁 Repository Structure
```css
.
├── aws-network-iac
│   ├── environments
│   │   ├── networking-prd
│   │   │   ├── backend.tf
│   │   │   ├── main.tf
│   │   │   ├── terraform.tfvars
│   │   │   └── variables.tf
│   │   └── networking-stg
│   │       ├── backend.tf
│   │       ├── main.tf
│   │       ├── terraform.tfvars
│   │       └── variables.tf
│   ├── modules
│   │   └── vpc
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       └── variables.tf
│   └── scripts
├── README.md
└── vpc_manager.sh
```

## 🚀 Getting Started

### Prerequisites
- Terraform installed
- AWS CLI configured with appropriate credentials


### Configuring Remote Backend with S3
By default, the Terraform configurations in this repository are set to use a specific S3 bucket for storing the remote state. To use your own S3 bucket, follow these steps:

#### Create an S3 Bucket
- Ensure you have an S3 bucket created to store your Terraform state files.

#### Configure the Backend

In your Terraform configuration directory (e.g., aws-network-iac/environments/networking-staging/us-west-1), create a file named backend.tf with the following content:

```terraform
terraform {
  backend "s3" {
    bucket         = "your-unique-bucket-name"
    key            = "path/to/your/terraform.tfstate"
    region         = "your-aws-region"
    encrypt        = true
  }
}
```

Replace the placeholders with your actual bucket name, desired state file path, AWS region, and DynamoDB table name if applicable.

#### Initialize the Backend:

Run the following command to initialize the backend configuration:
```terraform
$ terraform init
```

Terraform will prompt you to migrate your existing state to the new backend. Confirm the migration to complete the setup.

```Note```: The backend block does not support variable interpolation. Therefore, you must hardcode the values as shown above.


### Usage
The vpc_manager.sh script automates the provisioning and teardown of VPC environments.

Syntax:
```bash
$ ./vpc_manager.sh <environment_directory> [up|down]
```

Parameters:

- ```<environment_directory>```: Path to the target environment directory (e.g., aws-network-iac/environments/networking-staging/us-west-1)
- ```up```: Provision the infrastructure
- ```down```: Destroy the infrastructure

## ⚙️ Features
- Modular Terraform code for reusable infrastructure components;
- Support for multiple environments and AWS regions;
- Automated provisioning and teardown via shell script;
- Customizable VPC configurations for various use cases;

## 📝 License
This project is licensed under the MIT License.