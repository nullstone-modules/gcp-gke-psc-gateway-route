// Overrides the default GCP LB health check so each app's hostname is only healthy
// when its own pods pass the app's health endpoint.
resource "kubernetes_manifest" "health-check-policy" {
  manifest = {
    apiVersion = "networking.gke.io/v1"
    kind       = "HealthCheckPolicy"

    metadata = {
      name      = local.resource_name
      namespace = local.kubernetes_namespace
      labels    = local.k8s_labels
    }

    spec = {
      default = {
        config = {
          type = "HTTP"
          httpHealthCheck = {
            portSpecification = "USE_SERVING_PORT"
            requestPath       = var.health_check_path
          }
        }
      }
      targetRef = {
        group = ""
        kind  = "Service"
        name  = local.service_name
      }
    }
  }
}
