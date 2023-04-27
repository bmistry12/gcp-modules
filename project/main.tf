################################################################################
# Locals
################################################################################

locals {
  project         = var.project
  project_id      = var.project_id
  folder_projects = var.folder_projects
  region          = var.region
  billing_project = var.billing_project
  zone            = var.zone
  iam_policy      = var.iam_policy
  organisation    = var.organisation
  use_folders     = var.use_folders
  team_name       = var.team
  billing_projects = {
    "" = "" # for projects not assigned to a billing account.
    "" = "111111-222222-333333"
  }
  enabled_apis = toset(var.enabled_apis)
}

################################################################################
# Data
################################################################################

data "google_organization" "org" {
  domain = var.organisation
}

################################################################################
# Resources
################################################################################

# Project - Only create if folders are not in use. Project goes under an org.
resource "google_project" "project" {
  count           = local.use_folders == false ? 1 : 0
  name            = local.project
  project_id      = local.project_id
  org_id          = trimprefix(data.google_organization.org.id, "organizations/")
  billing_account = local.billing_projects[local.billing_project]
  labels = {
    "team" = local.team_name
  }
}

resource "google_project_iam_policy" "project_policy" {
  count       = local.iam_policy != "" ? 1 : 0
  project     = trimprefix(google_project.project[count.index].id, "projects/")
  policy_data = local.iam_policy
}

# Project - Creates when folders are in use. Project goes under a folder.
resource "google_project" "folder_project" {
  for_each        = local.folder_projects
  name            = each.key
  project_id      = each.key
  folder_id       = each.value[0]
  billing_account = local.billing_projects[local.billing_project]
  labels = {
    "team" = each.value[1]
  }
}
