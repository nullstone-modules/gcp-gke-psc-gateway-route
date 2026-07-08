data "ns_connection" "gateway" {
  name     = "gateway"
  contract = "ingress/gcp/gateway:gke-psc"
}

locals {
  gateway_name      = data.ns_connection.gateway.outputs.gateway_name
  gateway_namespace = data.ns_connection.gateway.outputs.gateway_namespace
  service_domain    = data.ns_connection.gateway.outputs.service_domain

  // Apps on the gateway are addressed as <app-name>.<service_domain> (i.e.
  // "<app-name>.<dns_name>.<internal_domain>"). The load balancer routes by Host header,
  // so consumers must resolve the gateway's service domain to their PSC endpoint.
  hostname = "${local.block_name}.${local.service_domain}"
}
