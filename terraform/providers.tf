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


  # To be picked from env variables
  access_key = <key>
  secret_key = <secret>
  
}