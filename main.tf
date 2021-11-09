locals {
  bucket = "${var.project}-tfstate"
}

terraform {
  backend "gcs" {
    bucket = local.bucket
  }
}

provider "google" {
  project = var.project
}