variable "project" {
    description = "Google project id. Override with TF_VAR_project"
    default = "PROJECT_ID"
}

terraform {
  backend "gcs" {
    bucket = "slalom-2020-293920-tfstate"
  }
}

provider "google" {
  project = var.project
}
