terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.38.0"
    }
    random = "~> 3.4.3"
  }
}

provider "aws" {
  # Configuration options
}