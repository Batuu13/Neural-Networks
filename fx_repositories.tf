module "freetrade-fx" {
  source = "./modules/freetrade_repository"

  repository_name        = "freetrade-fx"
  repository_description = "Contains components of the Freetrade FX Service."
  default_branch_name    = "develop"
  release_branch         = true
  require_linear_history = false
  bots_team              = true

  required_status_checks_contexts = [
    "ci/circleci: lint-and-build",
    "ci/circleci: unit-tests",
    "ci/circleci: integration-tests",
    "ci/circleci: tf-plan-ci"
  ]

  required_status_checks_contexts_release = [
    "ci/circleci: integration-tests-ci",
    "ci/circleci: kube-apply-ci",
    "ci/circleci: kube-apply-preproduction",
    "ci/circleci: migrate-db-ci",
    "ci/circleci: migrate-db-preproduction",
    "ci/circleci: publish-api-utils-package",
    "ci/circleci: publish-db-migrations-package",
    "ci/circleci: push-images-ci",
    "ci/circleci: tf-apply-ci",
    "ci/circleci: tf-apply-preproduction",
    "ci/circleci: tf-plan-ci",
    "ci/circleci: tf-plan-preproduction"
  ]
}

resource "github_team_repository" "fx_engineering_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.freetrade-fx.repository_name
  permission = "push"
}

resource "github_team_repository" "fx_team_repository" {
  team_id    = github_team.fx.id
  repository = module.freetrade-fx.repository_name
  permission = "push"
}

module "freetrade-fx-fix-engines" {
  source = "./modules/freetrade_repository"

  repository_name        = "freetrade-fx-fix-engines"
  repository_description = "Connects to our FX partners via FIX"
  default_branch_name    = "develop"
  release_branch         = true
  require_linear_history = false

  required_status_checks_contexts = [
    "ci/circleci: lint-and-test"
  ]

  required_status_checks_contexts_release = [
    "ci/circleci: build-and-push",
    "ci/circleci: deploy-preproduction"
  ]
}

resource "github_team_repository" "fx_fix_engineering_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.freetrade-fx-fix-engines.repository_name
  permission = "push"
}

resource "github_team_repository" "fx_fix_team_repository" {
  team_id    = github_team.fx.id
  repository = module.freetrade-fx-fix-engines.repository_name
  permission = "push"
}

module "client-statements" {
  source = "./modules/freetrade_repository"

  repository_name        = "client-statements"
  repository_description = "Client Statements generates & serves PDF statements for client accounts"

  allow_merge_commit = false

  require_conversation_resolution = true
  required_status_checks_contexts = [
    "commitlint",
    "ci/circleci: build-and-push"
  ]
}

resource "github_team_repository" "client_statements_eng_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.client-statements.repository_name
  permission = "push"
}

resource "github_team_repository" "client_statements_team_repository" {
  team_id    = github_team.post_trade.id
  repository = module.client-statements.repository_name
  permission = "push"
}