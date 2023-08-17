module "acquisitions-infra" {
  source = "./modules/freetrade_repository"

  repository_name        = "acquisitions-infra"
  repository_description = "Acquisitions infrastructure repository"

  allow_merge_commit = false
  allow_squash_merge = false
  allow_rebase_merge = true

  required_status_checks_contexts = [
    "ci/circleci: validate",
    "ci/circleci: plan-non-prod"
  ]
}

resource "github_team_repository" "acquisitions_infra_eng_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.acquisitions-infra.repository_name
  permission = "push"
}