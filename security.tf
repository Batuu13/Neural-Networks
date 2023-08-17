# Security Team
data "github_team" "security" {
  slug = "security"
}

module "security-rules" {
  source = "./modules/freetrade_repository"

  repository_name        = "security-rules"
  repository_description = "Repository for rules used by the Security team for threat detection"
  default_branch_name    = "main"
}

resource "github_team_repository" "security-rules_team_repository" {
  team_id    = data.github_team.security.id
  repository = module.security-rules.repository_name
  permission = "push"
}

# security-snyk-test
module "security-snyk" {
  source = "./modules/freetrade_repository"

  repository_name        = "security-snyk"
  repository_description = "Repository for the testing of Snyk"
  default_branch_name    = "main"
}

resource "github_team_repository" "security-snyk_team_repository" {
  team_id    = data.github_team.security.id
  repository = module.security-snyk.repository_name
  permission = "push"
}
