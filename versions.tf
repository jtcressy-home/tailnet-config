terraform {
  required_providers {
    onepassword = {
      source  = "1Password/onepassword"
      version = "1.1.4"
    }
    tailscale = {
      source  = "davidsbond/tailscale"
      version = "0.13.5"
    }
    github = {
      source  = "integrations/github"
      version = "4.24.1"
    }
  }
  required_version = ">=1.0"
}