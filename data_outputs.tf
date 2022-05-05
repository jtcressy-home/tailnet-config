data "tailscale_devices" "all_devices" {}

output "tailscale_devices" {
  value = jsonencode(data.tailscale_devices.all_devices.devices)
}