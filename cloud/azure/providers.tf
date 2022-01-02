terraform {
  required_providers {
    azurerm = "~> 2.33"
    random  = "~> 2.2"
  }
}
provider "azurerm" {
  features {}
}