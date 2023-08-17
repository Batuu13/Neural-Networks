module "pagerduty_scripts" {
  source = "./modules/freetrade_repository"

  repository_name        = "pagerduty-scripts"
  repository_description = "Repo containing pagerduty scripts for bulk adjusting services and gathering data via the CLI"

  allow_merge_commit = false
  allow_squash_merge = false
  allow_rebase_merge = true
}

resource "github_team_repository" "engineering_team_pagerduty_scripts" {
  team_id    = var.engineering_team_slug
  repository = module.pagerduty_scripts.repository_name
  permission = "push"
}

module "apollo_router_poc" {
  source = "./modules/freetrade_repository"

  repository_name        = "apollo-router-poc"
  repository_description = "Repo containing a proof of concept demo of how we can build a micro-service acrchitecture leveraging Apollo Federation"

  allow_merge_commit = false
  allow_squash_merge = false
  allow_rebase_merge = true
}

resource "github_team_repository" "engineering_team_apollo_router_poc" {
  team_id    = var.engineering_team_slug
  repository = module.apollo_router_poc.repository_name
  permission = "push"
}
