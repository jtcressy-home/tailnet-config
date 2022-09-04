resource "tailscale_dns_nameservers" "this" {
  nameservers = [
    "8.8.8.8",
    "8.8.4.4"
  ]
}

resource "tailscale_dns_preferences" "this" {
  magic_dns = true
}