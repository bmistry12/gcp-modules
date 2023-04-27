################################################################################
# Locals
################################################################################

locals {
  organisation  = var.organisation
  parent_folder = var.parent_folder
  teams         = toset(var.team_names)
}

################################################################################
# Data
################################################################################

data "google_organization" "org" {
  domain = var.organisation
}

################################################################################
# Top Level Folder
################################################################################

resource "google_folder" "parent_folder" {
  display_name = local.parent_folder
  parent       = data.google_organization.org.id
}

################################################################################
# Sub Folders
################################################################################

resource "google_folder" "team_folder" {
  for_each     = local.teams
  display_name = "${local.parent_folder}-${each.value}"
  parent       = google_folder.parent_folder.name
}
