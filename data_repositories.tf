data "github_team" "data_engineering" {
  slug = "data-engineering"
}

module "freetrade-data-dbt-utils" {
  source = "./modules/freetrade_repository"

  repository_name        = "freetrade-data-dbt-utils"
  repository_description = "Library of common dbt utils maintained by the data team"

  allow_merge_commit = false

}

resource "github_team_repository" "freetrade_data_dbt_utils_engineering_team" {
  team_id    = var.engineering_team_slug
  repository = module.freetrade-data-dbt-utils.repository_name
  permission = "push"
}

resource "github_team_repository" "freetrade_data_dbt_utils_data_team_push" {
  team_id    = data.github_team.data_engineering.id
  repository = module.freetrade-data-dbt-utils.repository_name
  permission = "push"
}

module "freetrade-data-feature-store" {
  source = "./modules/freetrade_repository"

  repository_name        = "freetrade-data-feature-store"
  repository_description = "Repository containg Feature Store DBT models, Feast config and related"

  allow_merge_commit = false

}

resource "github_team_repository" "freetrade_data_feature_store_engineering_team" {
  team_id    = var.engineering_team_slug
  repository = module.freetrade-data-feature-store.repository_name
  permission = "push"
}

resource "github_team_repository" "freetrade_data_feature_store_data_team_push" {
  team_id    = data.github_team.data_engineering.id
  repository = module.freetrade-data-feature-store.repository_name
  permission = "push"
}

module "freetrade-schema-store" {
  source = "./modules/freetrade_repository"

  repository_name        = "freetrade-schema-store"
  repository_description = "A store of centrally managed schemas"

  allow_merge_commit = false

}

resource "github_team_repository" "freetrade_schema_store_engineering_team" {
  team_id    = var.engineering_team_slug
  repository = module.freetrade-schema-store.repository_name
  permission = "push"
}

resource "github_team_repository" "freetrade_schema_store_data_team" {
  team_id    = data.github_team.data_engineering.id
  repository = module.freetrade-schema-store.repository_name
  permission = "push"
}

module "freetrade-data-experimentation" {
  source = "./modules/freetrade_repository"

  repository_name        = "freetrade-data-experimentation"
  repository_description = "Freetrade experimentation framework"

  allow_merge_commit = false

  required_status_checks_contexts = [
    "ci/circleci: end_to_end_tests",
    "ci/circleci: local_tests",
    "ci/circleci: standard-pre-commit-checks",
    "ci/circleci: validation_of_yml_files"
  ]

}

resource "github_team_repository" "experimentation_engineering_team" {
  team_id    = var.engineering_team_slug
  repository = module.freetrade-data-experimentation.repository_name
  permission = "push"
}

resource "github_team_repository" "experimentation_data_team" {
  team_id    = data.github_team.data_engineering.id
  repository = module.freetrade-data-experimentation.repository_name
  permission = "push"
}

module "freetrade-data-environments" {
  source = "./modules/freetrade_repository"

  repository_name        = "freetrade-data-environments"
  repository_description = "Environment infrastructure for Freetrade data team"

  allow_merge_commit = false

}

resource "github_team_repository" "freetrade_data_environments_engineering_team" {
  team_id    = var.engineering_team_slug
  repository = module.freetrade-data-environments.repository_name
  permission = "push"
}

resource "github_team_repository" "freetrade_data_environments_data_team" {
  team_id    = data.github_team.data_engineering.id
  repository = module.freetrade-data-environments.repository_name
  permission = "push"
}


module "freetrade-data-ml" {
  source = "./modules/freetrade_repository"

  repository_name        = "freetrade-data-ml"
  repository_description = "Freetrade machine learning framework"

  required_status_checks_contexts = [
    "ci/circleci: local_tests",
    "ci/circleci: standard-pre-commit-checks"
  ]

}

resource "github_team_repository" "ml_engineering_team" {
  team_id    = var.engineering_team_slug
  repository = module.freetrade-data-ml.repository_name
  permission = "push"
}

resource "github_team_repository" "ml_data_team" {
  team_id    = data.github_team.data_engineering.id
  repository = module.freetrade-data-ml.repository_name
  permission = "push"
}

module "freetrade-txn-monitoring" {
  source = "./modules/freetrade_repository"

  repository_name        = "freetrade-txn-monitoring"
  repository_description = "Freetrade Transaction Monitoring Service"

  allow_merge_commit = false
}

resource "github_team_repository" "txn_monitoring_engineering_team" {
  team_id    = var.engineering_team_slug
  repository = module.freetrade-txn-monitoring.repository_name
  permission = "push"
}

resource "github_team_repository" "txn_monitoring_data_team" {
  team_id    = data.github_team.data_engineering.id
  repository = module.freetrade-txn-monitoring.repository_name
  permission = "push"
}


module "freetrade_airbyte" {
  source = "./modules/freetrade_repository"

  repository_name        = "Freetrade-airbyte"
  repository_description = "Infrastructure, tooling, config and scripts to faciliate a deployment of Airbyte"

  allow_merge_commit = false
}

resource "github_team_repository" "freetrade_airbyte_engineering_team" {
  team_id    = var.engineering_team_slug
  repository = module.freetrade_airbyte.repository_name
  permission = "push"
}

resource "github_team_repository" "freetrade_airbyte_data_team" {
  team_id    = data.github_team.data_engineering.id
  repository = module.freetrade_airbyte.repository_name
  permission = "push"
}
