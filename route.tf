resource "kubernetes_manifest" "route-to-service" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "HTTPRoute"

    metadata = {
      name      = "${local.resource_name}-http"
      namespace = local.kubernetes_namespace
      labels    = local.k8s_labels
    }

    spec = {
      parentRefs = [
        {
          kind      = "Gateway"
          name      = local.gateway_name
          namespace = local.gateway_namespace
        }
      ]

      hostnames = [local.hostname]

      rules = [
        {
          backendRefs = [
            {
              name = local.service_name
              port = local.service_port
            }
          ]
        }
      ]
    }
  }
}
