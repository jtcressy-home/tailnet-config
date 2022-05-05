resource "tailscale_dns_nameservers" "this" {
  nameservers = concat(
    data.dns_a_record_set.cloudflare_dns.addrs,
    data.dns_aaaa_record_set.cloudflare_dns.addrs
  )
}

resource "tailscale_dns_preferences" "this" {
  magic_dns = true
}