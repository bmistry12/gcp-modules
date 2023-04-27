###########################################################################
# APIs
###########################################################################

resource "google_project_service" "service_api" {
  for_each = local.enabled_apis
  project  = local.project_id
  service  = "${each.key}.googleapis.com"
  timeouts {}
  disable_dependent_services = false
  disable_on_destroy         = true
  depends_on = [
    google_project.project
  ]
}
