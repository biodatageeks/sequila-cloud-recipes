terraform {
  required_providers {
    azurerm = "~> 2.33"
    random  = "~> 2.2"
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.3.11"
    }
  }
}
provider "azurerm" {
  features {}
}

