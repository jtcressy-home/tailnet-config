terraform {
  required_providers {
    onepassword = {
      source  = "1Password/onepassword"
      version = "1.1.4"
    }
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.13.7"
    }
    github = {
      source  = "integrations/github"
      version = "5.23.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.14.0"
    }
  }
  required_version = ">=1.0"
}