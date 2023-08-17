# Workplace Technology Team
data "github_team" "workplace-tech" {
  slug = "workplace-tech"
}

module "workplace-tech-tools" {
  source = "./modules/freetrade_repository"

  repository_name        = "workplace-tech-tools"
  repository_description = "Repository for rules used by the Workplace Tech team for services and tooling."
  default_branch_name    = "main"
}

resource "github_team_repository" "workplace_tech_tools_repository" {
  team_id    = data.github_team.workplace-tech.id
  repository = module.workplace-tech-tools.repository_name
  permission = "push"
}

module "okta-terraform" {
  source = "./modules/freetrade_repository"

  repository_name        = "okta-terraform"
  repository_description = "Production Okta terraform configuration"
  default_branch_name    = "main"
}

resource "github_team_repository" "okta_terraform_repository" {
  team_id    = data.github_team.workplace-tech.id
  repository = module.okta-terraform.repository_name
  permission = "push"
}