data "ns_connection" "gateway" {
  name     = "gateway"
  contract = "ingress/gcp/gateway:gke-psc"
}

locals {
  gateway_name      = data.ns_connection.gateway.outputs.gateway_name
  gateway_namespace = data.ns_connection.gateway.outputs.gateway_namespace
}
