data "github_team" "trading" {
  slug = "trading"
}

module "trading_adhoc_jobs" {
  source = "./modules/freetrade_repository"

  repository_name        = "trading-adhoc-jobs"
  repository_description = "Adhoc jobs that need to be run once"
  require_linear_history = true

  required_status_checks_contexts = []
  allow_rebase_merge              = true
  allow_squash_merge              = true
  allow_merge_commit              = true
}

resource "github_team_repository" "adhoc_jobs_engineering_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.trading_adhoc_jobs.repository_name
  permission = "push"
}

resource "github_team_repository" "adhoc_jobs_team_repository" {
  team_id    = data.github_team.trading.id
  repository = module.trading_adhoc_jobs.repository_name
  permission = "push"
}

module "order_quoter" {
  source = "./modules/freetrade_repository"

  repository_name        = "order-quoter"
  repository_description = "Service responsible for providing order quotes"
  require_linear_history = true

  required_status_checks_contexts = []
  allow_rebase_merge              = false
  allow_squash_merge              = true
  allow_merge_commit              = false
}

resource "github_team_repository" "order_quoter_engineering_team_repository" {
  team_id    = var.engineering_team_slug
  repository = module.order_quoter.repository_name
  permission = "push"
}

resource "github_team_repository" "order_quoter_team_repository" {
  team_id    = data.github_team.trading.id
  repository = module.order_quoter.repository_name
  permission = "push"
}

module "trading_planning" {
  source = "./modules/freetrade_repository"

  repository_name        = "trading-planning"
  repository_description = "Trading Planning Repo"

  allow_merge_commit = false
  allow_squash_merge = false
  allow_rebase_merge = true
}

resource "github_team_repository" "engineering_team_trading_planning" {
  team_id    = var.engineering_team_slug
  repository = module.trading_planning.repository_name
  permission = "push"
}
