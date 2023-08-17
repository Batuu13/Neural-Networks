terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.19"
    }
    google = {
      source  = "hashicorp/google"
      version = "4.10.0"
    }
  }

  required_version = "1.3.0"

  backend "gcs" {
    bucket = "ft-sre-prod-1-tf-state"
    prefix = "repository-manager/state"
  }
}

provider "google" {}

// Get GITHUB_APP_ID, GITHUB_APP_INSTALLATION_ID, GITHUB_APP_PEM_FILE
data "google_secret_manager_secret_version" "github_app_id" {
  project = "ft-sre-prod-1"
  secret  = "repository-manager-github-app-id"
}
data "google_secret_manager_secret_version" "github_app_installation_id" {
  project = "ft-sre-prod-1"
  secret  = "repository-manager-github-app-installation-id"
}
data "google_secret_manager_secret_version" "github_app_pem" {
  project = "ft-sre-prod-1"
  secret  = "repository-manager-github-app-pem"
}

provider "github" {
  owner = "freetrade-io"
  app_auth {
    id              = data.google_secret_manager_secret_version.github_app_id.secret_data
    installation_id = data.google_secret_manager_secret_version.github_app_installation_id.secret_data
    pem_file        = base64decode(data.google_secret_manager_secret_version.github_app_pem.secret_data)
  }
}
