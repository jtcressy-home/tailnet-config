terraform {
  required_providers {
    onepassword = {
      source  = "1Password/onepassword"
      version = "1.1.4"
    }
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.17.2"
    }
    github = {
      source  = "integrations/github"
      version = "5.25.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.15.2"
    }
  }
  required_version = ">=1.0"
}