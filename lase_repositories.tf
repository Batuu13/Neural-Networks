data "github_team" "ledger_settlements" {
  slug = "ledger-settlements"
}

module "lase-planning" {
  source = "./modules/freetrade_repository"

  repository_name        = "lase-planning"
  repository_description = "Ledger and Settlements Planning Repo"

  allow_merge_commit = false
  allow_squash_merge = false
  allow_rebase_merge = true
}

resource "github_team_repository" "engineering_team_lase_planning" {
  team_id    = var.engineering_team_slug
  repository = module.lase-planning.repository_name
  permission = "push"
}

module "securities_lending_infra_repo" {
  source = "./modules/freetrade_repository"

  repository_name        = "securities-lending-infra"
  repository_description = "Terraform Infrastructure for Securities Lending"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = true

  require_code_owner_reviews = true
  required_status_checks_contexts = [
    "atlantis-prod/apply"
  ]
}

resource "github_team_repository" "securities_lending_infra_repo_team" {
  team_id    = var.engineering_team_slug
  repository = module.securities_lending_infra_repo.repository_name
  permission = "push"
}

module "ibm_mq_infra_repo" {
  source = "./modules/freetrade_repository"

  repository_name        = "ibm-mq-infra"
  repository_description = "Terraform Infrastructure for IBM MQ cluster"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = true

  require_code_owner_reviews = true
  required_status_checks_contexts = [
    "atlantis-prod/apply",
    "ci/circleci: terraform-fmt"
  ]
}

resource "github_team_repository" "ibm_mq_infra_repo_team" {
  team_id    = var.engineering_team_slug
  repository = module.ibm_mq_infra_repo.repository_name
  permission = "push"
}
