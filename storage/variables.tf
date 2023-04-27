variable "bucket_name" {
  type        = string
  description = "Name of the cloud storage bucket"
}

variable "cors_rules" {
  type    = any
  default = []
}

variable "enable_versioning" {
  type    = bool
  default = false
}

variable "force_destroy" {
  type    = bool
  default = false
}

variable "labels" {
  type    = map(any)
  default = {}
}

variable "lifecycle_rules" {
  type    = any
  default = []
}

variable "location" {
  type    = string
  default = "EU"
}

variable "requester_pays" {
  type    = bool
  default = false
}

variable "storage_class" {
  type    = string
  default = "STANDARD"
}

variable "websites" {
  type    = any
  default = []
}

variable "uniform_bucket_level_access" {
  type    = bool
  default = false
}

variable "location_specific_bucket" {
  type        = bool
  description = "Set to False if the Bucket name should not be prefixed by the bucket location"
  default     = true
}
