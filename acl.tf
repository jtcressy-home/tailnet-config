resource "tailscale_acl" "main" {
  acl = jsonencode({
    Groups : {
      "group:admins" : ["jtcressy@github", "keatontaylor@github"]
    }
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
    }
    ssh : [
      {
        action : "check"
        src : ["autogroup:members"]
        dst : ["autogroup:self"]
        users : ["autogroup:nonroot", "root"]
      }
    ]
  })
}