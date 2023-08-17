# Post Trade Team
resource "github_team" "post_trade" {
  name        = "post-trade"
  description = "Managed by terraform"
  privacy     = "closed"
}