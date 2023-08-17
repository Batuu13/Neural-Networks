module "freetrade_accounting_functions" {
  source = "./modules/freetrade_repository"

  repository_name        = "freetrade-accounting-functions"
  repository_description = "Accounting platform functions built on the Cloud Firestore"

  default_branch_name = "develop"
  release_branch      = true

  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = false

  has_downloads = true
  has_issues    = true
  has_projects  = true
  has_wiki      = true

  auto_init          = false
  archive_on_destroy = null

  require_linear_history = false

  required_status_checks_contexts = [
    # build-and-deploy workflow
    "ci/circleci: test-mono-functions",
    "ci/circleci: test-monolith",
    "ci/circleci: lint-and-build-monolith",
    "ci/circleci: integration-tests",
    "ci/circleci: build-and-test-cloud-run-apps",
    "ci/circleci: test-deploy-cloud-run-prod",
    "ci/circleci: test-deploy-cloud-run-preprod",
    "ci/circleci: build-images",
  ]

  required_status_checks_contexts_release = []
}

resource "github_team_repository" "eng_invest_repository_push" {
  team_id    = var.engineering_team_id
  repository = module.freetrade_accounting_functions.repository_name
  permission = "push"
}
