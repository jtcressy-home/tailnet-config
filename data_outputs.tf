data "tailscale_devices" "all_devices" {}

output "tailscale_devices" {
  value = jsonencode(data.tailscale_devices.all_devices.devices)
}

data "dns_a_record_set" "cloudflare_dns" {
  host = "one.one.one.one."
}

data "dns_aaaa_record_set" "cloudflare_dns" {
  host = "one.one.one.one."
}