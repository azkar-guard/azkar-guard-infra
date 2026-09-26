terraform {
  required_version = ">= 1.5"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.6"
    }
  }

  # Local state for now. Move to a remote backend (S3-compatible / k3s MinIO)
  # before anyone else touches this repo.
}

provider "github" {
  owner = var.org
  # Auth via GITHUB_TOKEN env var, e.g. `export GITHUB_TOKEN=$(gh auth token)`.
}
