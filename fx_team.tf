# FX Team
resource "github_team" "fx" {
  name        = "fx"
  description = "Managed by terraform"
  privacy     = "closed"
}