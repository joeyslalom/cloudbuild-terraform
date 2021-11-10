variable "project" {
    description = "Google project id. Override with TF_VAR_project"
    default = "PROJECT_ID"
}

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

// https://github.com/terraform-google-modules/terraform-google-pubsub
module "pubsub" {
  source  = "terraform-google-modules/pubsub/google"
  version = "~> 1.8"

  topic               = "tf-topic"
  project_id          = var.project
  grant_token_creator = false
}
