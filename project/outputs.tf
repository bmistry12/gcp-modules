output "all_billing_projects" {
  value = local.billing_projects
}

output "billing_project" {
  value = local.billing_project
}

output "folder_project_names" {
  value = {
    for key in google_project.folder_project : key.labels.team => key.name
  }
}

output "folder_project_ids" {
  value = {
    for key in google_project.folder_project : key.name => key.project_id
  }
}

output "organisation" {
  value = data.google_organization.org.id
}

output "project" {
  value = local.project
}

output "project_id" {
  value = local.project_id
}

output "region" {
  value = local.region
}

output "zone" {
  value = local.zone
}
