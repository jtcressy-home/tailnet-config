resource "tailscale_tailnet_key" "reusable" {
  reusable  = true
  ephemeral = false
}

resource "onepassword_item" "tailscale-key-reusable" {
  vault    = data.onepassword_vault.jtcressy-net-infra.uuid
  title    = "tailscale-key-reusable"
  category = "login"
  username = data.onepassword_item.tailscale-api.username
  password = tailscale_tailnet_key.reusable.key
  tags = [
    "ManagedByTerraform"
  ]
}

resource "tailscale_tailnet_key" "ghactions" {
  reusable  = true
  ephemeral = true
  tags = [
    "tag:ghactions"
  ]
}

resource "onepassword_item" "tailscale-key-ghactions" {
  vault    = data.onepassword_vault.jtcressy-net-infra.uuid
  title    = "tailscale-key-ghactions"
  category = "login"
  username = data.onepassword_item.tailscale-api.username
  password = tailscale_tailnet_key.ghactions.key
  tags = [
    "ManagedByTerraform"
  ]
}