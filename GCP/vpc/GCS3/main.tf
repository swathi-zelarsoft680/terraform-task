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

resource "google_storage_bucket" "static-site" {
  name          = "image-store.com"
  location      = "EU"
  force_destroy = true



resource "google_storage_bucket_object" "text" {
  name   = "butterfly.txt"
  content = "*** Welcome to DevOps world ***\n we have uploaded text file in swathi bucket"
  bucket = "${google_storage_bucket.static-site.name}"  
}