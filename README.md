# Collection of Terraform Modules for GCP :cloud:

This repository contains Terraform modules for creating and managing resources in Google Cloud Platform (GCP)

- [BigQuery](bigquery/README.md)
- [Cloud Storage Buckets](storage/README.md)
- [Folders](folder/README.md)
- [Projects](project/README.md)

## Getting Started
To use these mdoules, the following tools must be installed and configured:

- A GCP Account
- [Terraform](https://developer.hashicorp.com/terraform/downloads) </br>
  - Modules are compatible with Terraform version `0.14` through to `1.4.6`. </br> _Other versions may work but have not been formally tested._
  - They have been tested with the [GCP Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs) versions `3.6.0` through to `4.56.0`
- Google Cloud SDK ([gcloud](https://cloud.google.com/sdk/docs/install))

:bulb: Importing existing GCP infrastructure into Terraform using these modules? Check out [GCPorter](https://github.com/bmistry12/gcporter).

### Authenticatng the Google Provider (for Terraform)
1. Run `gcloud init`
2. (Then for Terraform) `gcloud auth application-default login`
