output "private_urls" {
  value = [
    {
      url = "http://${local.hostname}"
    }
  ]
}
