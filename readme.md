# Cloud Build with Terraform
Inspired by [Managing infrastructure as code with Terraform, Cloud Build, and GitOps](https://cloud.google.com/architecture/managing-infrastructure-as-code).

## Prerequisites
* Required APIs enabled
* `git` setup in Cloud Shell
* `gcloud config set project` setup in Cloud Shell

## Cloud Build
1. Create service account for CloudBuild to use for this repo

        gcloud iam service-accounts create cloudbuild-terraform \
            --display-name="Used by CloudBuild for the cloudbuild-terraform repo"
2. Grant service account the needed IAM roles

        gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT \
            --member=serviceAccount:cloudbuild-terraform@$GOOGLE_CLOUD_PROJECT.iam.gserviceaccount.com \
            --role=roles/iam.serviceAccountUser

        gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT \
            --member=serviceAccount:cloudbuild-terraform@$GOOGLE_CLOUD_PROJECT.iam.gserviceaccount.com \
            --role=roles/logging.logWriter

        gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT \
            --member=serviceAccount:cloudbuild-terraform@$GOOGLE_CLOUD_PROJECT.iam.gserviceaccount.com \
            --role=roles/storage.admin
3. Link repo and create trigger in CloudBuild. In the trigger configuration, use the service account in #1

## Terraform
1. Create GCS bucket, enable versioning

        gsutil mb gs://$GOOGLE_CLOUD_PROJECT-tfstate

        gsutil versioning set on gs://${GOOGLE_CLOUD_PROJECT}-tfstate

## GitHub

1. Update CloudBuild trigger branch to `.*`
2. Update GitHub repo:
    * Protect `master` branch
    * Require status check, add CloudBuild trigger

## PubSub
1. Grant CloudBuild service account pubsub.admin

        gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT \
            --member=serviceAccount:cloudbuild-terraform@$GOOGLE_CLOUD_PROJECT.iam.gserviceaccount.com \
            --role=roles/pubsub.admin

2. For projects before 8-Apr-21, add `iam.serviceAccountTokenCreator` to the PubSub service account https://cloud.google.com/pubsub/docs/push#setting_up_for_push_authentication

        gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT \
            --member="serviceAccount:service-${PROJECT_NUMBER}@gcp-sa-pubsub.iam.gserviceaccount.com" \
            --role='roles/iam.serviceAccountTokenCreator'
    
