terraform {
  backend "s3" {
    bucket  = "brisa-terraform"
    key     = "networking-stg/us-east-1/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
