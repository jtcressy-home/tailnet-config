provider "onepassword" {
  url = "http://localhost:8080"
}

data "onepassword_vault" "jtcressy-net-infra" {
  name = "jtcressy-net-infra"
}

provider "vault" {}

data "vault_generic_secret" "tailscale" {
  path = "generic/tailscale"
}

provider "tailscale" {
  api_key = data.vault_generic_secret.tailscale.data["api_key"]
  tailnet = data.vault_generic_secret.tailscale.data["tailnet"]
}

