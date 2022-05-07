# provider "google" {
#   credentials = file("/downloads/instance.json")
#   project     = "arwa-348512"
#   region      = "us-east1"

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("/downloads/instance.json")
  project     = "arwa-348512"
  region      = var.region
  # zone    = "us-east1-b"
}

