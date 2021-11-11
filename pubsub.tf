
locals {
  bucket = "${var.project}-tfstate"
}

// https://github.com/terraform-google-modules/terraform-google-pubsub
module "pubsub" {
  source  = "terraform-google-modules/pubsub/google"
  version = "~> 1.8"

  topic               = "tf-topic"
  project_id          = var.project
  grant_token_creator = false
}