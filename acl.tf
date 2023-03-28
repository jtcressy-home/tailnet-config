resource "tailscale_acl" "main" {
  acl = jsonencode({
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
        action : "allow"
        src : ["group:admins", "tag:ghactions"]
        dst : ["tag:homeudm", "tag:edgenode"]
        users : ["autogroup:nonroot", "root"]
      }
    ]
  })
}