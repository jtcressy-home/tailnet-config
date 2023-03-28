locals {
  tailscale_acl = jsonencode({
    Groups : {
      "group:admins" : ["jtcressy@github", "keatontaylor@github", "ajwhiteh@github"]
    }
    nodeAttrs : [
      {
        target : ["*"]
        attr : ["nextdns:4fd8e6"]
      },
      {
        target : ["autogroup:members"]
        attr : ["funnel"]
      }
    ]
    acls : [
      {
        // Allow all users access to all ports.
        action = "accept",
        users  = ["*"],
        ports  = ["*:*"],
      }
    ]
    tagOwners : {
      "tag:ghactions" : ["group:admins"]
      "tag:homeudm" : ["group:admins"]
      "tag:codespaces" : ["group:admins"]
      "tag:edgenode" : ["group:admins"]
      "tag:k8s-operator" : []
      "tag:k8s" : ["tag:k8s-operator"]
    }
    ssh : [
      {
        action : "check"
        src : ["autogroup:members"]
        dst : ["autogroup:self"]
        users : ["autogroup:nonroot", "root"]
      },
      {
        action : "accept"
        src : ["group:admins", "tag:ghactions"]
        dst : ["tag:homeudm", "tag:edgenode"]
        users : ["autogroup:nonroot", "root"]
      }
    ]
  })
}

resource "tailscale_acl" "main" {
  acl = <<EOF
// This tailnet's ACLs are maintained in https://github.com/jtcressy-home/tailnet-config
${local.tailscale_acl}
EOF
}