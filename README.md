# gcp-gke-psc-gateway-route

Routes traffic from a `gcp-gke-psc-gateway` (internal Gateway published via Private Service Connect) to a GKE app.

This capability creates:

- An `HTTPRoute` attaching the app to the PSC Gateway at the hostname `<app-name>.<internal_domain>` (the domain comes from the gateway's `internal_domain` output).
- A `HealthCheckPolicy` targeting the app's Service so the load balancer health-checks the app's own health endpoint (`health_check_path`, default `/health`).
  This keeps each hostname's health independent: if this app's pods go down, its hostname returns 503 while other apps on the same gateway stay healthy.

Consumers in allowlisted projects reach the app at `http://<app-name>.<internal_domain>` through their PSC endpoint (see the `gcp-gke-psc-gateway` README for consumer setup).
