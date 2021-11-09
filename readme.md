# Cloud Build with Terraform

## Prerequisites

1. Create service account for CloudBuild to use for this repo.

        gcloud iam service-accounts create cloudbuild-terraform \
            --display-name="Used by CloudBuild for the cloudbuild-terraform repo"
2. Create IAM role for service account

        gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT \
            --member=serviceAccount:cloudbuild-terraform@$GOOGLE_CLOUD_PROJECT.iam.gserviceaccount.com \
            --role=roles/iam.serviceAccountUser

        gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT \
            --member=serviceAccount:cloudbuild-terraform@$GOOGLE_CLOUD_PROJECT.iam.gserviceaccount.com \
            --role=roles/logging.logWriter
3. Link repo and create trigger in CloudBuild. In the trigger configuration, use the service account in #1