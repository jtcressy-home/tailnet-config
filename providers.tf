provider "onepassword" {
  url = "http://localhost:8080"
}

data "onepassword_vault" "jtcressy-net-infra" {
  name = "jtcressy-net-infra"
}

provider "vault" {}

data "vault_kv_secret_v2" "tailscale" {
  mount = "generic"
  name  = "tailscale"
}

provider "tailscale" {
  api_key = data.vault_kv_secret_v2.tailscale.data["api_key"]
  tailnet = data.vault_kv_secret_v2.tailscale.data["tailnet"]
}

