# Generic
variable "billing_project" {
  type        = string
  description = "The billing project"
  default     = ""
}

variable "region" {
  type        = string
  description = "The GCP region."
  default     = "europe-west2"
}

variable "zone" {
  type        = string
  description = "The GCP zone."
  default     = ""
}

# Project related
variable "iam_policy" {
  description = "IAM policy data"
  default     = ""
}

variable "project" {
  type        = string
  description = "The GCP project name."
  default     = "" # Note: this must be set if you are creating a base project
}

variable "project_id" {
  type        = string
  description = "The GCP project id (must be unique)."
  default     = "" # Note: this must be set if you are creating a base project
}

variable "organisation" {
  type        = string
  description = "The organisation"
  default     = "xxx.com"
}

variable "team" {
  description = "Name of the team that a project belongs to (if not using folders)"
  default     = ""
}

# Folder related
variable "folder_projects" {
  description = "All projects required within the folder"
  default     = {}
}

variable "use_folders" {
  description = "Set to True if folders are being used."
  default     = false
}

variable "enabled_apis" {
  description = "List of APIs to enable."
  default     = []
}
