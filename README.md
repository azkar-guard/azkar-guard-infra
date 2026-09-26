# azkar-guard-infra

Terraform for the `azkar-guard` GitHub org: repos, settings and `main` branch protection.

## What it manages

| Repo | Phase |
|---|---|
| azkar-guard-infra | this repo |
| azkar-guard-browser-extension | 1 |
| azkar-guard-vscode-extension | 2 |
| azkar-guard-website | 3 |
| azkar-guard-api | 3 |

Phase 4 (`azkar-guard-jetbrains`) and Phase 5 (`azkar-guard-mobile`) are held back. Add them to `var.repos` when they get a go-ahead.

The org itself was created manually. GitHub has no API for creating orgs on github.com.

## Usage

```bash
export GITHUB_TOKEN=$(gh auth token)   # needs `repo` scope and org owner
terraform init
terraform plan
terraform apply
```

## Notes

- State is local for now (`terraform.tfstate`, gitignored). Move it to a remote backend before sharing.
- Branch protection needs public repos on the Free plan.
- Repos have `prevent_destroy`. Removing one from `var.repos` fails the plan on purpose.
