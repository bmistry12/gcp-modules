output "parent_folder_name" {
  value = google_folder.parent_folder.name
}

output "team_folder_name" {
  value = {
    for k, v in google_folder.team_folder : k => v.name
  }
}
