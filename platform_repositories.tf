data "github_team" "sres" {
  slug = "sres"
}

data "github_team" "corporate_actions" {
  slug = "corporate-actions"
}

# platform-atlantis repository
module "platform-atlantis" {
  source = "./modules/freetrade_repository"

  repository_name        = "platform-atlantis"
  repository_description = "Repository for Atlantis deployment"
  default_branch_name    = "main"
}

resource "github_team_repository" "platform-atlantis_team_repository" {
  team_id    = data.github_team.engineers.id
  repository = module.platform-atlantis.repository_name
  permission = "push"
}

resource "github_team_repository" "platform-atlantis-poc_team_repository" {
  team_id    = data.github_team.engineering_managers.id
  repository = module.platform-atlantis.repository_name
  permission = "push"
}

# Temporarily allow security push perms to deploy Snyk to CI
resource "github_team_repository" "platform-atlantis-sec_team_repository" {
  team_id    = data.github_team.security.id
  repository = module.platform-atlantis.repository_name
  permission = "push"
}

# platform-cloudrun-poc repository
module "platform-cloudrun-poc" {
  source = "./modules/freetrade_repository"

  repository_name        = "platform-cloudrun-poc"
  repository_description = "Repository for Cloud Run Proof of Concept"
  default_branch_name    = "main"
}

resource "github_team_repository" "platform-cloudrun-poc_team_repository" {
  team_id    = data.github_team.engineers.id
  repository = module.platform-cloudrun-poc.repository_name
  permission = "push"
}

# nx-tools repository
module "nx_tools" {
  source = "./modules/freetrade_repository"

  repository_name        = "nx-tools"
  repository_description = "Repository for NX tooling"
  default_branch_name    = "main"

  bots_team      = true
  release_please = true

  allow_rebase_merge = false
  allow_squash_merge = true
  allow_merge_commit = false

  required_status_checks_contexts = [
    "commitlint",
    "ci/circleci: lint",
    "ci/circleci: test-node-16",
    "ci/circleci: test-node-14",
    "ci/circleci: test-node-17",
    "ci/circleci: test-node-lts"
  ]
}

resource "github_team_repository" "nx_tools_sres_team_repository" {
  team_id    = data.github_team.sres.id
  repository = module.nx_tools.repository_name
  permission = "push"
}

resource "github_team_repository" "nx_tools_engineering_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.nx_tools.repository_name
  permission = "push"
}

# skeletor repository
module "skeletor" {
  source = "./modules/freetrade_repository"

  repository_name        = "skeletor"
  repository_description = "Repository for Skeleton project examples"
  default_branch_name    = "main"

  allow_rebase_merge = false
  allow_squash_merge = true
  allow_merge_commit = false
}

resource "github_team_repository" "skeletor_sres_team_repository" {
  team_id    = data.github_team.sres.id
  repository = module.skeletor.repository_name
  permission = "push"
}

resource "github_team_repository" "skeletor_engineering_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.skeletor.repository_name
  permission = "push"
}

# platform-atlantis-demo repository
module "platform-atlantis-demo" {
  source = "./modules/freetrade_repository"

  repository_name        = "platform-atlantis-demo"
  repository_description = "Repository to demo Atlantis workflow and integration"
  default_branch_name    = "main"
}

resource "github_team_repository" "platform-atlantis-demo_team_repository" {
  team_id    = data.github_team.sres.id
  repository = module.platform-atlantis-demo.repository_name
  permission = "push"
}

# freetrade-io/cloudflare-terraform
module "cloudflare_terraform" {
  source                 = "./modules/freetrade_repository"
  repository_name        = "cloudflare-terraform"
  repository_description = "Terraform configurations for Freetrade Cloudflare"
  default_branch_name    = "master"

  required_status_checks_contexts = [
    "atlantis-prod/apply"
  ]
}

resource "github_team_repository" "cloudflare_terraform" {
  team_id    = data.github_team.sres.id
  repository = module.cloudflare_terraform.repository_name
  permission = "push"
}

# freetrade-io/terraform-modules
module "terraform_modules" {
  source                 = "./modules/freetrade_repository"
  repository_name        = "terraform-modules"
  repository_description = "Freetrade Terraform Modules Mono Repo"

  required_status_checks_contexts = [
  ]
}

resource "github_team_repository" "terraform_modules_platform_team" {
  team_id    = data.github_team.sres.id
  repository = module.terraform_modules.repository_name
  permission = "push"
}

resource "github_team_repository" "terraform_modules_engineering_team" {
  team_id    = var.engineering_team_slug
  repository = module.terraform_modules.repository_name
  permission = "push"
}

# Open Telemetry Collector Demo Repository
module "observability-infra" {
  source = "./modules/freetrade_repository"

  repository_name        = "observability-infra"
  repository_description = "Additional infrastructure and configuration related to observability"
  default_branch_name    = "main"

  allow_rebase_merge = false
  allow_squash_merge = true
  allow_merge_commit = false
}

resource "github_team_repository" "observability_infra_sres_team_repository" {
  team_id    = data.github_team.sres.id
  repository = module.observability-infra.repository_name
  permission = "push"
}

resource "github_team_repository" "observability_infra_engineering_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.observability-infra.repository_name
  permission = "push"
}

# Observability shared library Repository
module "observability_library" {
  source = "./modules/freetrade_repository"

  repository_name        = "observability-libs"
  repository_description = "Library containing observability tools"
  default_branch_name    = "main"
  bots_team              = true
  release_please         = true

  allow_rebase_merge = false
  allow_squash_merge = true
  allow_merge_commit = false
}

resource "github_team_repository" "observability_library_sres_team_repository" {
  team_id    = data.github_team.sres.id
  repository = module.observability_library.repository_name
  permission = "push"
}

resource "github_team_repository" "observability_library_engineering_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.observability_library.repository_name
  permission = "push"
}

# gcp-org-terraform repository
module "gcp-org-terraform" {
  source = "./modules/freetrade_repository"

  repository_name        = "gcp-org-terraform"
  repository_description = "Terraform code for GCP org"
  default_branch_name    = "main"

  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true

  require_code_owner_reviews = true
  required_status_checks_contexts = [
    "atlantis-prod/apply"
  ]
}

resource "github_team_repository" "gcp_org_terraform_data_engineering_team_repository" {
  team_id    = data.github_team.data_engineering.id
  repository = module.gcp-org-terraform.repository_name
  permission = "push"
}

data "github_team" "engineers" {
  slug = var.engineering_team_slug
}

resource "github_team_repository" "gcp_org_terraform_engineers_repository" {
  team_id    = data.github_team.engineers.id
  repository = module.gcp-org-terraform.repository_name
  permission = "push"
}

data "github_team" "engineering_managers" {
  slug = var.engineering_managers_team_slug
}

resource "github_team_repository" "gcp_org_terraform_engineering_managers_repository" {
  team_id    = data.github_team.engineering_managers.id
  repository = module.gcp-org-terraform.repository_name
  permission = "push"
}

resource "github_team_repository" "gcp_org_terraform_post_trade_team_repository" {
  team_id    = github_team.post_trade.id
  repository = module.gcp-org-terraform.repository_name
  permission = "push"
}

resource "github_team_repository" "gcp_org_terraform_security_team_repository" {
  team_id    = data.github_team.security.id
  repository = module.gcp-org-terraform.repository_name
  permission = "push"
}

data "github_team" "snyk_service_account" {
  slug = "snyk-service-account"
}

resource "github_team_repository" "gcp_org_terraform_snyk_service_account_repository" {
  team_id    = data.github_team.snyk_service_account.id
  repository = module.gcp-org-terraform.repository_name
  permission = "pull"
}

resource "github_team_repository" "gcp_org_terraform_sres_team_repository" {
  team_id    = data.github_team.sres.id
  repository = module.gcp-org-terraform.repository_name
  permission = "push"
}

data "github_team" "tech_leads" {
  slug = "tech-leads"
}

resource "github_team_repository" "gcp_org_terraform_tech_leads_repository" {
  team_id    = data.github_team.tech_leads.id
  repository = module.gcp-org-terraform.repository_name
  permission = "push"
}

resource "github_team_repository" "gcp_org_terraform_trading_team_repository" {
  team_id    = data.github_team.trading.id
  repository = module.gcp-org-terraform.repository_name
  permission = "push"
}

resource "github_team_repository" "gcp_org_terraform_web_engineers_team_repository" {
  team_id    = data.github_team.web_engineers.id
  repository = module.gcp-org-terraform.repository_name
  permission = "push"
}

resource "github_team_repository" "gcp_org_terraform_corporate_actions_team_repository" {
  team_id    = data.github_team.corporate_actions.id
  repository = module.gcp-org-terraform.repository_name
  permission = "push"
}

# wall-e repository
module "wall-e" {
  source = "./modules/freetrade_repository"

  repository_name        = "wall-e"
  repository_description = ""
  default_branch_name    = "develop"

  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true
}

resource "github_team_repository" "wall_e_engineers_repository" {
  team_id    = data.github_team.engineers.id
  repository = module.wall-e.repository_name
  permission = "push"
}

resource "github_team_repository" "wall_e_snyk_service_account_repository" {
  team_id    = data.github_team.snyk_service_account.id
  repository = module.wall-e.repository_name
  permission = "pull"
}

# Shared Network infrastructure
module "shared_network_infra" {
  source = "./modules/freetrade_repository"

  repository_name        = "shared-network-infra"
  repository_description = "Shared VPC infrastructure"
  default_branch_name    = "main"

  allow_rebase_merge = false
  allow_squash_merge = true
  allow_merge_commit = false
}

resource "github_team_repository" "shared_network_infra_sres_team_repository" {
  team_id    = data.github_team.sres.id
  repository = module.shared_network_infra.repository_name
  permission = "push"
}

resource "github_team_repository" "shared_network_infra_engineering_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.shared_network_infra.repository_name
  permission = "push"
}

# pagerduty-humaniser
module "pagerduty_humaniser" {
  source = "./modules/freetrade_repository"

  repository_name        = "pagerduty-humaniser"
  repository_description = "PagerDuty humaniser"
  default_branch_name    = "main"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false
}

resource "github_team_repository" "pagerduty_humaniser_engineering_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.pagerduty_humaniser.repository_name
  permission = "push"
}

resource "github_team_repository" "pagerduty_humaniser_sres_team_repository" {
  team_id    = data.github_team.sres.id
  repository = module.pagerduty_humaniser.repository_name
  permission = "push"
}

# 1Password SCIM bridge
module "op-scim-bridge-kubernetes" {
  source = "./modules/freetrade_repository"

  repository_name        = "op-scim-bridge-kubernetes"
  repository_description = "1Password SCIM bridge kubernetes deployment"
  default_branch_name    = "main"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false
}

resource "github_team_repository" "op-scim-bridge-kubernetes_sres_team_repository" {
  team_id    = data.github_team.sres.id
  repository = module.op-scim-bridge-kubernetes.repository_name
  permission = "push"
}

# GCP Service Accounts
module "gcp-service-accounts" {
  source = "./modules/freetrade_repository"

  repository_name        = "gcp-service-accounts"
  repository_description = "GCP Service Account project repository"
  default_branch_name    = "main"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false
}

resource "github_team_repository" "gcp-service-accounts_sec_team_repository" {
  team_id    = data.github_team.security.id
  repository = module.gcp-service-accounts.repository_name
  permission = "push"
}

resource "github_team_repository" "gcp-service-accounts_plat_team_repository" {
  team_id    = data.github_team.sres.id
  repository = module.gcp-service-accounts.repository_name
  permission = "push"
}

module "decoupling_poc" {
  source = "./modules/freetrade_repository"

  repository_name        = "decoupling-proof-of-concept"
  repository_description = "A concept repository to decoupling the monolith"
  default_branch_name    = "main"

  allow_rebase_merge = false
  allow_squash_merge = true
  allow_merge_commit = false
}

resource "github_team_repository" "decoupled_poc_engineering_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.decoupling_poc.repository_name
  permission = "push"
}

module "feature_toggle_service" {
  source = "./modules/freetrade_repository"

  repository_name        = "feature-toggle-service"
  repository_description = "A decoupled feature toggle service"
  default_branch_name    = "main"

  allow_rebase_merge = false
  allow_squash_merge = true
  allow_merge_commit = false
}

resource "github_team_repository" "feature_toggle_service_engineering_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.feature_toggle_service.repository_name
  permission = "push"
}

module "base_environment" {
  source = "./modules/freetrade_repository"

  repository_name        = "base-environment"
  repository_description = "Repository to contain IaC for shared environment"
  default_branch_name    = "main"

  allow_rebase_merge = false
  allow_squash_merge = true
  allow_merge_commit = false
}

resource "github_team_repository" "base_environment_engineering_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.base_environment.repository_name
  permission = "push"
}
