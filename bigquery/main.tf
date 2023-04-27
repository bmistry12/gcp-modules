locals {
  labels = merge(
    {
      "name"          = var.dateset_name != "" ? replace(var.dateset_name, ".", "-") : replace(var.dataset_id, ".", "-")
      "generator"     = "terraform"
      "configuration" = replace(element(split("terraform/", path.cwd), 1), "/", "_") # / isnt valid

    },
    var.labels
  )
  iam_to_primitive = {
    "bigquery.dataOwner" : "OWNER"
    "bigquery.dataEditor" : "WRITER"
    "bigquery.dataViewer" : "READER"
  }

  access_rules = [for access_rule in var.access_rules : merge(local.access_rules_default, access_rule)]
  access_rules_default = {
    domain        = ""
    group_email   = ""
    role          = ""
    user_by_email = ""
    special_group = ""
  }
  encryption_key = var.encryption_key
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = var.dataset_id
  friendly_name               = var.dateset_name
  description                 = var.description
  location                    = var.location
  default_table_expiration_ms = var.default_table_expiration
  delete_contents_on_destroy  = var.delete_contents_on_destroy
  labels                      = local.labels

  access {
    special_group = "projectOwners"
    role          = "OWNER"
  }
  access {
    special_group = "projectReaders"
    role          = "READER"
  }
  access {
    special_group = "projectWriters"
    role          = "WRITER"
  }

  dynamic "access" {
    for_each = local.access_rules
    content {
      role          = lookup(local.iam_to_primitive, access.value.role, access.value.role)
      user_by_email = access.value.user_by_email != null ? access.value.user_by_email : null
      special_group = access.value.special_group != null ? access.value.special_group : null
    }
  }
  dynamic "default_encryption_configuration" {
    for_each = local.encryption_key == null ? [] : [local.encryption_key]
    content {
      kms_key_name = local.encryption_key
    }
  }
}
