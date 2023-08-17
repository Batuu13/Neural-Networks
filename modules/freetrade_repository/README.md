<!-- BEGIN_TF_DOCS -->
## Description

Represents a standardised Github Repository at Freetrade with sensible defaults.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.13.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="repository_name"></a> [repository_name](#repository_name) | The name of the repository. | `string` | n/a | yes |
| <a name="repository_description"></a> [repository_description](#repository_description) | A description for the repository. | `string` | n/a | yes |
| <a name="required_status_checks_contexts"></a> [required_status_checks_contexts](#required_status_checks_contexts) | The set of status checks required to pass before a PR can be merged. | `set(string)` | [] | yes |
| <a name="required_linear_history"></a> [required_linear_history](#required_linear_history) | Setting this to true enforces a linear commit Git history on the develop branch, this prevents anyone from pushing merge commits to it | `bool` | false | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->