# These rules locations are configured with VSCode Remote Containers as the
# primary use case. For different paths run:
# make RULES_DIR=<rules/path> RULES_TARGET=$(pwd) semgrep
RULES_DIR = /workspaces/platform-tools/semgrep/rules/terraform
RULES_TARGET = /workspaces/repository-manager

.PHONY: init
init: ## Initialise Terraform configuration without a backend
	terraform init -backend=false -reconfigure

.PHONY: validate
validate: ## Validate Terraform configuration
	terraform validate .

.PHONY: fmt
fmt: ## Format Terraform configuration
	terraform fmt -recursive -list=true -write=true .

.PHONY: clean
clean: ## Remove existing Terraform state and modules
	rm -rf .terraform/

.PHONY: all
all: clean init validate fmt

.PHONY: semgrep
semgrep: ## Run Semgrep rules
	semgrep --no-error --config $(RULES_DIR) --metrics=off $(RULES_TARGET)
