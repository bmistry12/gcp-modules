locals {
  labels = merge(
    {
      "name"          = replace(var.bucket_name, ".", "-")
      "generator"     = "terraform"
      "configuration" = replace(element(split("terraform/", path.cwd), 1), "/", "_") # / isnt valid
    },
    var.labels
  )

  cors_rules = [for cors_rule in var.cors_rules : merge(local.cors_rules_default, cors_rule)]
  cors_rules_default = {
    origin          = []
    method          = []
    response_header = []
    max_age_seconds = 0
  }
  websites = [for website in var.websites : merge(local.websites_default, website)]
  websites_default = {
    main_page_suffix = ""
    not_found_page   = ""
  }
  lifecycle_rules = [for lifecycle_rule in var.lifecycle_rules : merge(local.lifecycle_rules_default, lifecycle_rule)]
  lifecycle_rules_default = {
    type                       = "SetStorageClass"
    storage_class              = null
    age                        = 0
    with_state                 = "ANY"
    num_newer_versions         = 0
    matches_prefix             = []
    matches_storage_class      = []
    matches_suffix             = []
    num_newer_versions         = 0
    days_since_custom_time     = 0
    days_since_noncurrent_time = 0
  }
}

resource "google_storage_bucket" "bucket" {
  name                        = var.location_specific_bucket ? "${lower(var.location)}.${var.bucket_name}" : var.bucket_name
  location                    = var.location
  force_destroy               = var.force_destroy
  storage_class               = var.storage_class
  requester_pays              = var.requester_pays
  labels                      = local.labels
  default_event_based_hold    = false
  uniform_bucket_level_access = var.uniform_bucket_level_access
  timeouts {}

  versioning {
    enabled = var.enable_versioning
  }

  dynamic "cors" {
    for_each = local.cors_rules
    content {
      origin          = cors.value.origin
      method          = cors.value.method
      response_header = cors.value.response_header
      max_age_seconds = cors.value.max_age_seconds
    }
  }

  dynamic "website" {
    for_each = local.websites
    content {
      main_page_suffix = website.value.main_page_suffix
      not_found_page   = website.value.not_found_page
    }
  }

  dynamic "lifecycle_rule" {
    for_each = local.lifecycle_rules
    content {
      action {
        type          = lifecycle_rule.value.type
        storage_class = lifecycle_rule.value.type == "Delete" ? null : lifecycle_rule.value.storage_class
      }
      condition {
        age                        = lifecycle_rule.value.age
        with_state                 = lifecycle_rule.value.with_state
        matches_prefix             = lifecycle_rule.value.matches_prefix
        matches_suffix             = lifecycle_rule.value.matches_suffix
        matches_storage_class      = lifecycle_rule.value.matches_storage_class
        num_newer_versions         = lifecycle_rule.value.num_newer_versions
        days_since_custom_time     = lifecycle_rule.value.days_since_custom_time
        days_since_noncurrent_time = lifecycle_rule.value.days_since_noncurrent_time
      }
    }
  }
}
