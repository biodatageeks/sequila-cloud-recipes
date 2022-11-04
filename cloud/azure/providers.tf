terraform {
  required_providers {
    azurerm = "~> 3.30.0"
    random  = "~> 3.4.3"
  }
}
provider "azurerm" {
  features {}
}