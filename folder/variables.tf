variable "organisation" {
  type        = string
  description = "The organisation"
  default     = "xxx.com"
}

variable "parent_folder" {
  type        = string
  description = "Parent folder name"
}

variable "team_names" {
  description = "Names of the teams that require subfolders."
  default     = []
}
