output "repository_name" {
  value = github_repository.repository.name
}

# See https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository
resource "github_repository" "repository" {
  name        = var.repository_name
  description = var.repository_description

  visibility = "private"

  allow_auto_merge       = var.allow_auto_merge
  archive_on_destroy     = var.archive_on_destroy
  delete_branch_on_merge = var.delete_branch_on_merge
  auto_init              = var.auto_init

  has_downloads = var.has_downloads
  has_issues    = var.has_issues
  has_projects  = var.has_projects
  has_wiki      = var.has_wiki

  allow_merge_commit = var.allow_merge_commit
  allow_squash_merge = var.allow_squash_merge
  allow_rebase_merge = var.allow_rebase_merge

  lifecycle {
    ignore_changes = [
      branches
    ]
  }
}

resource "github_branch" "default" {
  count      = var.default_branch_name != "main" ? 1 : 0
  repository = github_repository.repository.name
  branch     = var.default_branch_name
}

resource "github_branch_default" "default" {
  count      = var.default_branch_name != "main" ? 1 : 0
  repository = github_repository.repository.name
  branch     = github_branch.default[0].branch
}

resource "github_branch_protection" "default" {
  repository_id = github_repository.repository.name

  pattern          = var.default_branch_name != "main" ? github_branch.default[0].branch : "main"
  enforce_admins   = true
  allows_deletions = false

  required_linear_history         = var.require_linear_history
  require_conversation_resolution = var.require_conversation_resolution

  required_status_checks {
    strict   = true
    contexts = var.required_status_checks_contexts
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    required_approving_review_count = var.required_reviewer_count
    require_code_owner_reviews      = var.require_code_owner_reviews
  }
}

resource "github_branch" "release" {
  count      = var.release_branch ? 1 : 0
  repository = github_repository.repository.name
  branch     = "release"
}

resource "github_branch_protection" "release" {
  count         = var.release_branch ? 1 : 0
  repository_id = github_repository.repository.name

  pattern          = github_branch.release[0].branch
  enforce_admins   = true
  allows_deletions = false

  required_status_checks {
    strict   = true
    contexts = var.required_status_checks_contexts_release
  }

  required_pull_request_reviews {
    required_approving_review_count = 1
  }
}

# GitHub NPM requires write access to the repository to publish packages
resource "github_team_repository" "bots_team" {
  count      = var.bots_team ? 1 : 0
  team_id    = var.bots_team_slug
  repository = github_repository.repository.name
  permission = "push"
}

resource "github_repository_collaborator" "release_please_collaborator" {
  count      = var.release_please ? 1 : 0
  username   = var.release_please_username
  repository = github_repository.repository.name
  permission = "push"
}
