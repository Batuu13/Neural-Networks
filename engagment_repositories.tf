module "autopilot_repo" {
  source = "./modules/freetrade_repository"

  repository_name        = "autopilot"
  repository_description = "Repo containing apps relating to auto investment"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = true
}

resource "github_team_repository" "autopilot_repo_team" {
  team_id    = var.engineering_team_slug
  repository = module.autopilot_repo.repository_name
  permission = "push"
}
