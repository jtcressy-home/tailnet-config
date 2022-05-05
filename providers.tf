provider "onepassword" {
  url = "http://localhost:8080"
}

data "onepassword_vault" "jtcressy-net-infra" {
  name = "jtcressy-net-infra"
}

data "onepassword_item" "tailscale-api" {
  vault = data.onepassword_vault.jtcressy-net-infra.uuid
  title = "tailscale-api"
}

provider "tailscale" {
  api_key = data.onepassword_item.tailscale-api.password
  tailnet = "jtcressy-home.org.github"
}