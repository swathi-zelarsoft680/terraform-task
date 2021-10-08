terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("C:/Users/ragsr/Downloads/zelarsoft-99636fd402c8.json")

  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_storage_bucket" "GCP1" {
  name          = "swathi"
  location      = "EU"
  force_destroy = true

}