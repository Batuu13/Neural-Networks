data "github_team" "web_engineers" {
  slug = "web-engineers"
}

# web-client repository (poc)
module "web_client" {
  source = "./modules/freetrade_repository"

  repository_name        = "web-client"
  repository_description = "POC using next.js and contentful to recreate marketing style blog pages"
  allow_merge_commit     = false
  allow_squash_merge     = false
  allow_rebase_merge     = true
}

resource "github_team_repository" "web_client_team_repository" {
  team_id    = data.github_team.web_engineers.id
  repository = module.web_client.repository_name
  permission = "push"
}

# web-app repository
module "web_app" {
  source = "./modules/freetrade_repository"

  repository_name        = "web-app"
  repository_description = "Freetrade web app"
  allow_merge_commit     = false
  allow_squash_merge     = false
  allow_rebase_merge     = true

  required_status_checks_contexts = [
    "ci/circleci: test",
    "ci/circleci: build-and-push-docker",
  ]
}

resource "github_team_repository" "web_app_eng_repo_permission" {
  team_id    = var.engineering_team_slug
  repository = module.web_app.repository_name
  permission = "push"
}

resource "github_team_repository" "web_app_design_repo_permission" {
  team_id    = var.design_team_slug
  repository = module.web_app.repository_name
  permission = "pull"
}

resource "github_repository_autolink_reference" "autolink_webeng" {
  repository = module.web_app.repository_name

  key_prefix = "WEBENG-"

  target_url_template = "https://freetrade.atlassian.net/browse/WEBENG-<num>"
}

# web-grafana repository
module "web_grafana" {
  source = "./modules/freetrade_repository"

  repository_name        = "web-grafana"
  repository_description = "Grafana for Web"
  allow_merge_commit     = false
  allow_squash_merge     = false
  allow_rebase_merge     = true
}

resource "github_team_repository" "web_grafana_eng_repo_permission" {
  team_id    = var.engineering_team_slug
  repository = module.web_grafana.repository_name
  permission = "push"
}
