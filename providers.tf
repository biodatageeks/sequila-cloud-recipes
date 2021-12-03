terraform {
  required_providers {
    azurerm = "~> 2.33"
    random  = "~> 2.2"
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.3.11"
    }
    google = {
      source  = "hashicorp/google"
      version = "4.2.0"
    }
  }
}
provider "azurerm" {
  features {}
}

provider "google" {
  # Configuration options
}