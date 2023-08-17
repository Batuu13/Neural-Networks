module "close-of-business" {
  source = "./modules/freetrade_repository"

  repository_name        = "close-of-business"
  repository_description = "Close Of business generates the COB statements"

  allow_merge_commit = false

  required_status_checks_contexts = []
}

resource "github_team_repository" "close_of_business_eng_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.close-of-business.repository_name
  permission = "push"
}

resource "github_team_repository" "close_of_business_team_repository" {
  team_id    = github_team.post_trade.id
  repository = module.close-of-business.repository_name
  permission = "push"
}

module "post-trade-infra" {
  source = "./modules/freetrade_repository"

  repository_name        = "post-trade-infra"
  repository_description = "Post Trade infrastructure repository"

  allow_merge_commit = false
  allow_squash_merge = false
  allow_rebase_merge = true

  require_conversation_resolution = true
  required_status_checks_contexts = [
    "atlantis-prod/apply"
  ]
}

resource "github_team_repository" "post_trade_infra_eng_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.post-trade-infra.repository_name
  permission = "push"
}

resource "github_team_repository" "post_trade_infra_team_repository" {
  team_id    = github_team.post_trade.id
  repository = module.post-trade-infra.repository_name
  permission = "push"
}

module "post-trade-kubernetes" {
  source = "./modules/freetrade_repository"

  repository_name        = "post-trade-kubernetes"
  repository_description = "Post Trade kubernetes state repository"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false

  require_conversation_resolution = true
  required_status_checks_contexts = [
    "ci/circleci: validate-manifests",
  ]

  release_please = true
}

resource "github_repository_deploy_key" "argocd_post_trade_kubernetes_non_prod" {
  title      = "ArgoCD Dev"
  repository = "post-trade-kubernetes"
  key        = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJENl3ZCFpW+VyD2SKzmegF2/MVVohuESqDb0m7wO39a post-trade-dev-argocd-ssh"
  read_only  = "false"
}

resource "github_repository_deploy_key" "argocd_post_trade_kubernetes_prod" {
  title      = "ArgoCD Prod"
  repository = "post-trade-kubernetes"
  key        = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGDkTa/Qvc6U4n4MVzc2IMnJ5/hRDwWONAbnfD6X1ELP post-trade-prod-argocd-ssh"
  read_only  = "false"
}

resource "github_team_repository" "post_trade_kubernetes_eng_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.post-trade-kubernetes.repository_name
  permission = "push"
}

resource "github_team_repository" "post_trade_kubernetes_team_repository" {
  team_id    = github_team.post_trade.id
  repository = module.post-trade-kubernetes.repository_name
  permission = "push"
}

module "event_store_poc_repository" {
  source = "./modules/freetrade_repository"

  repository_name        = "event-store-poc"
  repository_description = "EventstoreDB Poc"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = true

  required_status_checks_contexts = []
}

resource "github_team_repository" "event_store_poc_eng_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.event_store_poc_repository.repository_name
  permission = "push"
}

resource "github_team_repository" "event_store_poc_team_repository" {
  team_id    = github_team.post_trade.id
  repository = module.event_store_poc_repository.repository_name
  permission = "push"
}

module "securities_lending_repository" {
  source = "./modules/freetrade_repository"

  repository_name        = "securities-lending"
  repository_description = "Repository for services in the securities lending domain"

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = true

  require_conversation_resolution = true

  required_status_checks_contexts = [
    "commitlint",
    "ci/circleci: build-and-push",
    "ci/circleci: unit-test",
    "ci/circleci: integration-test",
    "ci/circleci: lint"
  ]
}

resource "github_team_repository" "securities_lending_eng_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.securities_lending_repository.repository_name
  permission = "push"
}

resource "github_team_repository" "securities_lending_team_repository" {
  team_id    = github_team.post_trade.id
  repository = module.securities_lending_repository.repository_name
  permission = "push"
}

module "ts_metrics_repository" {
  source = "./modules/freetrade_repository"

  repository_name        = "ts-metrics"
  repository_description = "Repository for npm package to that can be used to in k8 services to expose metrics"
  bots_team              = true

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = true

  require_conversation_resolution = true
  required_status_checks_contexts = ["commitlint"]
}

resource "github_team_repository" "ts_metrics_eng_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.ts_metrics_repository.repository_name
  permission = "push"
}

resource "github_team_repository" "ts_metrics_team_repository" {
  team_id    = github_team.post_trade.id
  repository = module.ts_metrics_repository.repository_name
  permission = "push"
}
