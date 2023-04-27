# GCP BigQuery Terraform Module

This module currently creates a BigQuery dataset in Google Cloud Platform (GCP) using Terraform. The dataset can be customized using the variables provided.

## Usage Example

```hcl
module "bigquery_dataset" {
  source = "path/to/module"

  dataset_id                  = "my-dataset-id"
  dataset_name                = "My Dataset Name"
  description                 = "My Dataset Description"
  location                    = "eu-west1"
  default_table_expiration    = 3600
  delete_contents_on_destroy  = false
  labels = {
    environment = "dev"
  }
  access_rules = [
    {
      role          = "bigquery.dataOwner"
      user_by_email = "user1@example.com"
    },
    {
      role          = "bigquery.dataEditor"
      group_email   = "group1@example.com"
    },
    {
      role          = "bigquery.dataViewer"
      domain        = "example.com"
    },
  ]
  encryption_key = "projects/123456789/locations/eu-west1/keyRings/my-keyring/cryptoKeys/my-key"
}
```

## Input Variables
| Name                     | Description                                              | Type           | Default | Required |
| ------------------------ | -------------------------------------------------------- | -------------- | ------- | -------- |
| `dataset_id`             | The ID of the dataset to create.                         | `string`       | n/a     | Yes      |
| `dataset_name`           | The friendly name of the dataset.                        | `string`       | `""`    | No       |
| `description`            | The description of the dataset.                          | `string`       | `""`    | No       |
| `location`               | The location where the dataset will be created.          | `string`       | n/a     | Yes      |
| `default_table_expiration` | The default expiration time for tables created in the dataset. | `number` | `null`  | No       |
| `delete_contents_on_destroy` | Whether to delete all tables in the dataset when destroying the resource. | `bool` | `false` | No |
| `labels`                 | The labels to apply to the dataset.                      | `map(string)`  | `{}`    | No       |
| `access_rules`           | The access rules to apply to the dataset.                | `list(map(string))` | `[]` | No       |
| `encryption_key`         | The KMS encryption key to use for the dataset.            | `string`       | `null`  | No       |


# Output Variables
| Name              | Description                        |
| ----------------- | ----------------------------------- |
| `id`      | The ID of the created dataset.      |
| `url`       | The URI of the dataset resource.    |
