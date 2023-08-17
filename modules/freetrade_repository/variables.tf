variable "repository_name" {
  type = string
}

variable "repository_description" {
  type = string
}

variable "default_branch_name" {
  type    = string
  default = "main"
}

variable "release_branch" {
  type    = bool
  default = false
}

variable "required_status_checks_contexts" {
  type        = set(string)
  description = "Names of the status checks required to pass before a PR can be merged into the main branch."
  default     = []
}

variable "required_status_checks_contexts_release" {
  type        = set(string)
  description = "Names of the status checks required to pass before a PR can be merged into the release branch. If not provided falls back to required_status_checks_contexts."
  default     = []
}

variable "require_conversation_resolution" {
  type        = bool
  description = "When true, all conversations on code must be resolved before a pull request can be merged."
  default     = false
}

variable "require_linear_history" {
  type    = bool
  default = false
}

variable "required_reviewer_count" {
  type    = number
  default = 1
}

variable "require_code_owner_reviews" {
  type    = bool
  default = false
}

variable "allow_merge_commit" {
  type    = bool
  default = true
}

variable "allow_squash_merge" {
  type    = bool
  default = true
}

variable "allow_rebase_merge" {
  type    = bool
  default = false
}

variable "bots_team" {
  type        = bool
  default     = false
  description = "When true, the Bots team will be given write (push) access to the repository"
}

variable "bots_team_slug" {
  type    = string
  default = "bots"
}

variable "release_please" {
  type        = bool
  default     = false
  description = "When true, the ft-svc-3 user will have access to the repository to use the RELEASE_PLEASE_PAT_TOKEN"
}

variable "release_please_username" {
  type    = string
  default = "ft-svc-3"
}

variable "has_downloads" {
  type    = bool
  default = null
}

variable "has_issues" {
  type    = bool
  default = null
}

variable "has_projects" {
  type    = bool
  default = null
}

variable "has_wiki" {
  type    = bool
  default = true
}

variable "allow_auto_merge" {
  type    = bool
  default = true
}

variable "archive_on_destroy" {
  type    = bool
  default = true
}

variable "delete_branch_on_merge" {
  type    = bool
  default = true
}

variable "auto_init" {
  type    = bool
  default = true
}
