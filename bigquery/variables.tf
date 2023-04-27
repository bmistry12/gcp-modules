variable "dataset_id" {
  description = "Unique ID of the bigquery dataset"
  type        = string
}

variable "dateset_name" {
  description = "Name of the bigquery dataset"
  type        = string
  default     = ""
}

variable "description" {
  description = "Description of the dataset"
  type        = string
  default     = ""
}

variable "location" {
  description = "The regional location of the dataset"
  type        = string
  default     = "US"
  validation {
    condition     = contains(["US", "EU", "europe-west2"], var.location)
    error_message = "Location must be one of (US|EU|europe-west2)"
  }
}

variable "default_table_expiration" {
  description = "TTL of tables using the dataset in MS"
  type        = number
  default     = null # never
}

variable "delete_contents_on_destroy" {
  type    = bool
  default = false
}

variable "encryption_key" {
  description = "Default encryption key to apply to the dataset."
  type        = string
  default     = null # Google-managed
}

variable "labels" {
  default = {}
}

variable "access_rules" {
  type    = any
  default = []
}
