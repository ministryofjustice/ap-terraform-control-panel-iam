variable "resource_prefix" {
  description = "The prefix for the resources this control panel IAM can manage"
  type        = string
}

variable "provider_url" {
  description = "URL of the cluster OIDC Provider"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to IAM role resources"
  type        = map(string)
  default     = {}
}

variable "control_panel_service_account" {
  description = "The service account for the control panel "
  type        = string
}
