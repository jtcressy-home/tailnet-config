data "tailscale_devices" "all_devices" {}

data "dns_a_record_set" "cloudflare_dns" {
  host = "one.one.one.one."
}

data "dns_aaaa_record_set" "cloudflare_dns" {
  host = "one.one.one.one."
}
