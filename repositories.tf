module "commitlint" {
  source = "./modules/freetrade_repository"

  repository_name        = "commitlint"
  repository_description = "Freetrade's commit linting rules"
  bots_team              = true

  required_status_checks_contexts = [
    "ci/circleci: lint"
  ]
}

resource "github_team_repository" "commitlint_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.commitlint.repository_name
  permission = "push"
}

module "ts_money" {
  source = "./modules/freetrade_repository"

  repository_name        = "ts-money"
  repository_description = "Typescript Money representation"
  bots_team              = true

  required_status_checks_contexts = [
    "ci/circleci: lint",
    "ci/circleci: test-node-16",
    "ci/circleci: test-node-14"
  ]
}

module "ts_tracing" {
  source = "./modules/freetrade_repository"

  repository_name        = "ts-tracing"
  repository_description = "Express middleware for logging/tracing"
  bots_team              = true

  required_status_checks_contexts = [
    "ci/circleci: lint",
    "ci/circleci: test",
  ]
}

resource "github_team_repository" "ts_tracing_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.ts_tracing.repository_name
  permission = "push"
}

resource "github_team_repository" "ts_tracing_team_repository_push_permissions" {
  team_id    = var.engineering_team_slug
  repository = module.ts_tracing.repository_name
  permission = "push"
}

resource "github_team_repository" "ts_money_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.ts_money.repository_name
  permission = "push"
}

resource "github_team_repository" "ts_money_team_repository_push_permissions" {
  team_id    = var.engineering_team_slug
  repository = module.ts_money.repository_name
  permission = "push"
}

module "ft_build" {
  source = "./modules/freetrade_repository"

  repository_name        = "ft-build"
  repository_description = "Freetrade build tooling"
  bots_team              = true

  required_status_checks_contexts = [
    "ci/circleci: lint",
  ]
}

resource "github_team_repository" "ft_build_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.ft_build.repository_name
  permission = "push"
}

resource "github_team_repository" "ft_build_team_repository_admin_permissions" {
  team_id    = var.engineering_team_slug
  repository = module.ft_build.repository_name
  permission = "push"
}

module "plutus" {
  source = "./modules/freetrade_repository"

  repository_name                 = "plutus"
  repository_description          = "An experimental price streamer implementation in golang"
  bots_team                       = true
  required_status_checks_contexts = []
}

resource "github_team_repository" "plutus_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.plutus.repository_name
  permission = "push"
}

module "raycast_extension" {
  source = "./modules/freetrade_repository"

  repository_name        = "raycast-extension"
  repository_description = "A Raycast app extension to quickly access various Freetrade cloud consoles"
  require_linear_history = true

  required_status_checks_contexts = []
  allow_rebase_merge              = false
  allow_squash_merge              = true
  allow_merge_commit              = false
}

resource "github_team_repository" "raycast_extension_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.raycast_extension.repository_name
  permission = "push"
}

resource "github_team_repository" "raycast_extension_team_repository_push_permissions" {
  team_id    = var.engineering_team_slug
  repository = module.raycast_extension.repository_name
  permission = "push"
}

module "ts_grpc_repository" {
  source = "./modules/freetrade_repository"

  repository_name        = "ts-grpc"
  repository_description = "Additional gRPC functionality written in Typescript"
  bots_team              = true
  release_please         = true

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false

  required_status_checks_contexts = [
    "commitlint",
    "ci/circleci: build-and-test"
  ]
}

resource "github_team_repository" "ts_grpc_eng_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.ts_grpc_repository.repository_name
  permission = "push"
}

module "ts_event_sourcing_repository" {
  source = "./modules/freetrade_repository"

  repository_name        = "ts-event-sourcing"
  repository_description = "Freetrade's event sourcing framework written in Typescript"
  bots_team              = true
  release_please         = true

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false

  required_status_checks_contexts = [
    "commitlint",
    "ci/circleci: build-and-test"
  ]
}

resource "github_team_repository" "ts_event_sourcing_eng_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.ts_event_sourcing_repository.repository_name
  permission = "push"
}

module "qa_tools_repository" {
  source = "./modules/freetrade_repository"

  repository_name        = "qa-tools"
  repository_description = "Freetrade's QA tools repository"
  bots_team              = true

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false

  required_status_checks_contexts = []
}

resource "github_team_repository" "qa_tools_repository" {
  team_id    = "automation-engineers"
  repository = module.qa_tools_repository.repository_name
  permission = "push"
}

module "recurring_buys_research" {
  source = "./modules/freetrade_repository"

  repository_name        = "recurring-buys-research"
  repository_description = "Research for recurring orders"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false

  required_status_checks_contexts = []
}

resource "github_team_repository" "recurring_buys_research" {
  team_id    = var.engineering_team_slug
  repository = module.recurring_buys_research.repository_name
  permission = "push"
}

module "appropriateness_assessments" {
  source = "./modules/freetrade_repository"

  repository_name        = "appropriateness-assessments"
  repository_description = "Service to serve appropriateness assessments, and grade and store client assessments submissions"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false

  required_status_checks_contexts = []
}

resource "github_team_repository" "appropriateness_assessments_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.appropriateness_assessments.repository_name
  permission = "push"
}

module "trading_infrastructure" {
  source = "./modules/freetrade_repository"

  repository_name        = "trading-infrastructure"
  repository_description = "Repo to contain all the infrastructure for Trading team's projects"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false

  required_status_checks_contexts = []
}

resource "github_team_repository" "trading_infrastructure_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.trading_infrastructure.repository_name
  permission = "push"
}

module "ts_user_factory_testing_repository" {
  source = "./modules/freetrade_repository"

  repository_name        = "ts-user-factory-testing"
  repository_description = "Testing Library to create and manipulate test accounts in UAT"
  bots_team              = true
  release_please         = true

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false

  required_status_checks_contexts = []
}

resource "github_team_repository" "ts_user_factory_testing_repository" {
  team_id    = "automation-engineers"
  repository = module.ts_user_factory_testing_repository.repository_name
  permission = "push"
}

resource "github_team_repository" "ts_user_factory_testing_repository_push_permissions" {
  team_id    = var.engineering_team_slug
  repository = module.ts_user_factory_testing_repository.repository_name
  permission = "push"
}

module "backend_automation_repository" {
  source = "./modules/freetrade_repository"

  repository_name        = "backend-automation"
  repository_description = "Backend End-to-End Test Automation"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false

  required_status_checks_contexts = []
}

resource "github_team_repository" "backend_automation_repository" {
  team_id    = var.engineering_team_slug
  repository = module.backend_automation_repository.repository_name
  permission = "push"
}

resource "github_team_repository" "backend_automation_repository_push" {
  team_id    = "automation-engineers"
  repository = module.backend_automation_repository.repository_name
  permission = "push"
}

module "webdriverio_automation_repository" {
  source = "./modules/freetrade_repository"

  repository_name        = "webdriverio-automation"
  repository_description = "WebdriverIO End-to-End Test Automation"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false

  required_status_checks_contexts = []
}

resource "github_team_repository" "webdriverio_automation_repository" {
  team_id    = var.engineering_team_slug
  repository = module.webdriverio_automation_repository.repository_name
  permission = "push"
}

resource "github_team_repository" "webdriverio_automation_repository_push" {
  team_id    = "automation-engineers"
  repository = module.webdriverio_automation_repository.repository_name
  permission = "push"
}

module "subscriptions" {
  source = "./modules/freetrade_repository"

  repository_name         = "subscriptions"
  repository_description  = "Service to serve and store client subscriptions and entitlements"
  required_reviewer_count = 1

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false

  required_status_checks_contexts = [
    "ci/circleci: lint",
    "ci/circleci: unit-tests",
    "ci/circleci: integration-tests",
    "ci/circleci: plan-dev-environment"
  ]
}

resource "github_team_repository" "subscriptions_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.subscriptions.repository_name
  permission = "push"
}

module "backstage" {
  source = "./modules/freetrade_repository"

  repository_name         = "backstage"
  repository_description  = "Freetrade developer portal built with Backstage.io"
  required_reviewer_count = 1

  require_linear_history          = true
  require_conversation_resolution = true

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false

  required_status_checks_contexts = []
}

resource "github_team_repository" "backstage_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.backstage.repository_name
  permission = "push"
}

module "insights" {
  source = "./modules/freetrade_repository"

  repository_name        = "insights"
  repository_description = "A service to serve and store historical portfolio and instrument prices and other insights"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false

  required_status_checks_contexts = []
}

resource "github_team_repository" "insights_repository" {
  team_id    = var.engineering_team_slug
  repository = module.insights.repository_name
  permission = "push"
}

module "investment_plans" {
  source = "./modules/freetrade_repository"

  repository_name        = "investment-plans"
  repository_description = "A Service to create and store investment plans, which will serve as the basis for recurring orders and eventually autopilot."

  default_branch_name = "develop"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false

  require_linear_history          = true
  require_conversation_resolution = true

  required_status_checks_contexts = []
}

resource "github_team_repository" "investment_plans_repository" {
  team_id    = var.engineering_team_slug
  repository = module.investment_plans.repository_name
  permission = "push"
}

module "gateways" {
  source = "./modules/freetrade_repository"

  repository_name        = "gateways"
  repository_description = "Services providing connection between consumers and backend services, exposing a unified and stable contracts"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false

  required_status_checks_contexts = []
}

resource "github_team_repository" "gateways_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.gateways.repository_name
  permission = "push"
}

module "client_assets" {
  source = "./modules/freetrade_repository"

  repository_name        = "client-assets"
  repository_description = "Provides a bucket that serves images (and other assets) used by client apps."

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false

  require_linear_history          = true
  require_conversation_resolution = true
  require_code_owner_reviews      = true

  required_status_checks_contexts = []
}

resource "github_team_repository" "client_assets_repository" {
  team_id    = var.engineering_team_slug
  repository = module.client_assets.repository_name
  permission = "push"
}

module "on_call_insights" {
  source = "./modules/freetrade_repository"

  repository_name        = "on-call-insights"
  repository_description = "Functions that ingest and store on-call data from 3rd parties"
  require_linear_history = true

  required_status_checks_contexts = []
  allow_rebase_merge              = false
  allow_squash_merge              = true
  allow_merge_commit              = false
}

resource "github_team_repository" "on_call_insights_engineering_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.on_call_insights.repository_name
  permission = "push"
}

module "core_kubernetes" {
  source = "./modules/freetrade_repository"

  repository_name        = "core-kubernetes"
  repository_description = "Core environment kubernetes state repository"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false

  require_conversation_resolution = true
  required_status_checks_contexts = [
    "ci/circleci: validate-rules"
  ]
}

resource "github_team_repository" "core_kubernetes_engineering_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.core_kubernetes.repository_name
  permission = "push"
}

module "onfido_data_migration" {
  source = "./modules/freetrade_repository"

  repository_name        = "onfido-data-migration"
  repository_description = "A repo to store a solution to migrate data from Onfido's SFTP server to GCS"

  default_branch_name = "develop"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false

  require_linear_history          = true
  require_conversation_resolution = true

  required_status_checks_contexts = []
}

resource "github_team_repository" "onfido_data_migration_repository" {
  team_id    = var.engineering_team_slug
  repository = module.onfido_data_migration.repository_name
  permission = "push"
}

module "payments" {
  source = "./modules/freetrade_repository"

  repository_name        = "payments"
  repository_description = "Repository housing services for payment-related things, such as direct debits or VRPs"

  default_branch_name = "develop"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false

  require_linear_history          = true
  require_conversation_resolution = true

  required_status_checks_contexts = [
    "ci/circleci: lint",
    "ci/circleci: unit-tests",
    #    "ci/circleci: integration-tests",
    "ci/circleci: plan-dev-environment",
    "ci/circleci: build-and-push-docker"
  ]
}

resource "github_team_repository" "payments_repository" {
  team_id    = var.engineering_team_slug
  repository = module.payments.repository_name
  permission = "push"
}

module "facades_repo" {
  source = "./modules/freetrade_repository"

  repository_name        = "facades"
  repository_description = "Repo containing apps facade apps to Client Platform"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = true
}

resource "github_team_repository" "facades_repo_team" {
  team_id    = var.engineering_team_slug
  repository = module.facades_repo.repository_name
  permission = "push"
}

module "declarations_repo" {
  source = "./modules/freetrade_repository"

  repository_name        = "declarations"
  repository_description = "Repo containing apps to return and submit declarations for clients"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = true
}

resource "github_team_repository" "declarations_repo_team" {
  team_id    = var.engineering_team_slug
  repository = module.declarations_repo.repository_name
  permission = "push"
}

module "analytics_repo" {
  source = "./modules/freetrade_repository"

  repository_name        = "analytics"
  repository_description = "Repo containing apps to set events and attributes to our 3rd parties"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = true

  required_status_checks_contexts = [
    "ci/circleci: lint",
    "ci/circleci: unit-tests",
    "ci/circleci: integration-tests"
  ]
}

resource "github_team_repository" "analytics_team" {
  team_id    = var.engineering_team_slug
  repository = module.analytics_repo.repository_name
  permission = "push"
}

module "technical_ops_repo" {
  source = "./modules/freetrade_repository"

  repository_name        = "technical-operations"
  repository_description = "Repo containing services that assist technical operations"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = true
}

resource "github_team_repository" "techinal_ops_tech_ops_team" {
  repository = module.technical_ops_repo.repository_name
  team_id    = var.tech_ops_team_slug
  permission = "push"
}

resource "github_team_repository" "techinal_ops_eng_team" {
  repository = module.technical_ops_repo.repository_name
  team_id    = var.engineering_team_slug
  permission = "push"
}

module "batu-repo_repo" {
    source = "./modules/freetrade_repository"

    repository_name        = "batu-repo"
    repository_description = "repo for batu"

    allow_merge_commit = false
    allow_squash_merge = true
    allow_rebase_merge = true
}

resource "github_team_repository" "batu-repo_team" {
    team_id    = var.engineering_team_slug
    repository = module.batu-repo_repo.repository_name
    permission = "push"
}
