terraform {
  required_providers {
    random = "~> 2.2"
    google = {
      source  = "hashicorp/google"
      version = "4.2.0"
    }
  }
}

provider "google" {
  # Configuration options
}