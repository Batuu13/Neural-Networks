# Corporate Actions Team
resource "github_team" "corporate_actions" {
  name        = "corporate-actions"
  description = "Managed by terraform"
  privacy     = "closed"
}

module "corporate-actions" {
  source = "./modules/freetrade_repository"

  repository_name        = "corporate-actions"
  repository_description = "Repository for services in the corporate actions domain"

  allow_merge_commit = false

  required_status_checks_contexts = [
    "commitlint"
  ]
}

resource "github_team_repository" "corporate_actions_engineering_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.corporate-actions.repository_name
  permission = "push"
}

resource "github_team_repository" "corporate_actions_team_repository" {
  team_id    = github_team.corporate_actions.id
  repository = module.corporate-actions.repository_name
  permission = "push"
}
