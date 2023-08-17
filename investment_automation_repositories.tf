data "github_team" "investment_automation" {
  slug = "investment-automation"
}

module "investment_automation" {
  source = "./modules/freetrade_repository"

  repository_name        = "investment-automation"
  repository_description = "Repository for services related to investment automation"
  default_branch_name    = "main"
}

resource "github_team_repository" "investment_automation_team_repository" {
  team_id    = data.github_team.investment_automation.id
  repository = module.investment_automation.repository_name
  permission = "push"
}
