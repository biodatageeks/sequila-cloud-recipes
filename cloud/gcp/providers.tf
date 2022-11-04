terraform {
  required_providers {
    random = "~> 2.2"
    google = {
      source  = "hashicorp/google"
      version = "4.42.0"
    }
  }
}

provider "google" {
  # Configuration options
}