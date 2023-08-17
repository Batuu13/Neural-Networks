# repository-manager

## What is this repo for

This repo is meant to hold all the infrastructure code for new repositories under Freetrade Limited.

Existing repositories can be migrated as needed.

Any new github teams or memberships are no longer managed by this repository. New teams and membership are handled by a Halp request.

Only push acess is permitted, if you require admin permissions you must raise a /halp request to be granted temporary access. See the [Notion](https://www.notion.so/freetrade/How-we-manage-Github-access-3bc0ab23b9f0421983e08d1ea8d99332) guide for more context

## How to deploy a new change

1. Add a new repository to [repositories.tf](repositories.tf)
2. Open a PR with the changes
3. Comment `atlantis plan`
4. Check the changes are what you expect
5. If happy, ask for a review from a friend
6. If approved, run `atlantis apply` to create the repository

## Folder structure

- [modules](modules) contains the modules used to encapsulate common configuration
- [teams](teams) contains the definitions of teams in Github
- [repositories.tf](repositories.tf) contains the definitions of repositories in Github
- [main.tf](main.tf) contains the backend and the provider definition