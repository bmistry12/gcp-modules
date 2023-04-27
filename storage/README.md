# GCP Cloud Storage Terraform Module

This Terraform module creates a Google Cloud Storage bucket with configurable options. The following options are available:

- Bucket name
- Location
- Storage class
- Requester pays
- Labels
- CORS rules
- Websites
- Lifecycle rules
- Versioning
- Uniform bucket-level access

## Usage Example

```hcl
module "gcs_bucket" {
  source  = "github.com/user/repo"
  bucket_name = "my-bucket"
  location = "us-central1"
  storage_class = "STANDARD"
  requester_pays = false
  labels = {
    "project" = "my-project"
    "env" = "prod"
  }
  cors_rules = [
    {
      origin = ["http://example.com"]
      method = ["GET"]
      response_header = ["Content-Type"]
      max_age_seconds = 3600
    }
  ]
  websites = [
    {
      main_page_suffix = "index.html"
      not_found_page = "404.html"
    }
  ]
  lifecycle_rules = [
    {
      type = "SetStorageClass"
      storage_class = "NEARLINE"
      age = 30
      with_state = "ANY"
      matches_prefix = ["logs/"]
      matches_storage_class = ["STANDARD"]
      matches_suffix = [".log"]
      num_newer_versions = 3
      days_since_custom_time = 15
      days_since_noncurrent_time = 30
    }
  ]
  enable_versioning = true
  uniform_bucket_level_access = false
  force_destroy = false
  location_specific_bucket = false
}
```

## Input Variables

| Name                 | Description                                                           | Type                                                                 | Default | Required |
|----------------------|-----------------------------------------------------------------------|----------------------------------------------------------------------|---------|----------|
| bucket_name          | The name of the bucket to create.                                     | string                                                               | n/a     | yes      |
| location             | The location of the bucket.                                           | string                                                               | n/a     | yes      |
| storage_class        | The storage class of the bucket.                                      | string                                                               | "STANDARD" | no       |
| requester_pays       | Whether requester pays is enabled.                                    | bool                                                                 | false   | no       |
| labels               | A map of labels to assign to the bucket.                               | map(string)                                                          | {}      | no       |
| cors_rules           | A list of CORS rules for the bucket.                                   | list(object({origin = list(string), method = list(string), response_header = list(string), max_age_seconds = number})) | []      | no       |
| websites             | A list of website configuration for the bucket.                        | list(object({main_page_suffix = string, not_found_page = string}))   | []      | no       |
| lifecycle_rules      | A list of lifecycle rules for the bucket.                              | list(object({type = string, storage_class = string, age = number, with_state = string, matches_prefix = list(string), matches_storage_class = list(string), matches_suffix = list(string), num_newer_versions = number, days_since_custom_time = number, days_since_noncurrent_time = number})) | [] | no       |
| enable_versioning    | Whether to enable versioning for the bucket.                           | bool                                                                 | false   | no       |
| uniform_bucket_level_access | Whether uniform bucket-level access is enabled.                  | bool                                                                 | false   | no       |
| force_destroy        | Whether to force destroy the bucket.                                   | bool                                                                 | false   | no       |
| location_specific_bucket | Whether to include the location in the bucket name.                    | bool                                                                 | false   | no       |



## Output Variables

| Name | Description | Type |
|------|-------------|------|
| url | The base URL of the bucket. | string |
| self_link | The URI of the bucket resource. | string |
| bucket_name | The name of the bucket. | string |

