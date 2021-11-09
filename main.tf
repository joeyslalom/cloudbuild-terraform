variable "project" {}

locals {
  bucket = "${var.project}-tfstate"
}

terraform {
  backend "gcs" {
    bucket = "slalom-2020-293920-tfstate"
  }
}

provider "google" {
  project = var.project
}