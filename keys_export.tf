resource "time_rotating" "tskey" {
  rotation_days = 30
}

resource "tailscale_tailnet_key" "reusable" {
  reusable  = true
  ephemeral = false

  lifecycle {
    replace_triggered_by = [time_rotating.tskey]
  }
}

resource "onepassword_item" "tailscale-key-reusable" {
  vault    = data.onepassword_vault.jtcressy-net-infra.uuid
  title    = "tailscale-key-reusable"
  category = "login"
  username = data.vault_kv_secret_v2.tailscale.data["tailnet"]
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
  depends_on = [tailscale_acl.main]

  lifecycle {
    replace_triggered_by = [time_rotating.tskey]
  }
}

resource "onepassword_item" "tailscale-key-ghactions" {
  vault    = data.onepassword_vault.jtcressy-net-infra.uuid
  title    = "tailscale-key-ghactions"
  category = "login"
  username = data.vault_kv_secret_v2.tailscale.data["tailnet"]
  password = tailscale_tailnet_key.ghactions.key
  tags = [
    "ManagedByTerraform"
  ]
}

resource "tailscale_tailnet_key" "home-udm" {
  reusable   = true
  ephemeral  = false
  tags       = ["tag:homeudm"]
  depends_on = [tailscale_acl.main]

  lifecycle {
    replace_triggered_by = [time_rotating.tskey]
  }
}

resource "vault_kv_secret_v2" "home-udm_ts-key" {
  mount               = "generic"
  name                = "home-udm/tailscale"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode({
    authkey = tailscale_tailnet_key.home-udm.key
  })
}