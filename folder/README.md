# GCP Folders Terraform Module

This module creates a set of folders within the GCP project in a hierarchical structure under a parent folder. This can be useful for organising resources and access control.

## Usage Example

```hcl
module "gcp_folders" {
  source          = "path/to/module"
  organisation    = "example.com"
  parent_folder   = "parent-folder"
  team_names      = ["team1", "team2", "team3"]
}
```

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `organisation` | The domain name of the GCP organization | `string` | n/a | yes |
| `parent_folder` | The name of the top-level folder to create under the GCP organization | `string` | n/a | yes |
| `team_names` | A list of team names to be used for creating subfolders | `list(string)` | `[]` | no |


## Output Variables

| Name | Description |
|------|-------------|
| `parent_folder_name` | The unique name of the parent folder |
| `team_folder_name` | A map of team names to their respective folder names |
