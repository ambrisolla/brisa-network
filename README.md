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

### Usage
The vpc_manager.sh script automates the provisioning and teardown of VPC environments.

Syntax:
```bash
$ ./vpc_manager.sh <environment_directory> [up|down]
```
## ⚙️ Features

- Modular Terraform code for reusable infrastructure components;
- Support for multiple environments and AWS regions;
- Automated provisioning and teardown via shell script;
- Customizable VPC configurations for various use cases;

## 📝 License
This project is licensed under the MIT License.