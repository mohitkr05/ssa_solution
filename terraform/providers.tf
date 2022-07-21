terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
    }
  }
required_version = ">= 1.2.0"
}

# Provider aws - To move configuration out of the code
provider "aws" {


  region  = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
  
}
