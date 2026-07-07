variable "app_metadata" {
  description = <<EOF
Nullstone automatically injects metadata from the app module into this module through this variable.
This variable is a reserved variable for capabilities.
EOF

  type    = map(string)
  default = {}
}

locals {
  service_name = var.app_metadata["service_name"]
  service_port = var.app_metadata["service_port"]
}

variable "health_check_path" {
  description = "The path the load balancer checks for app health."
  type        = string
  default     = "/health"
}
