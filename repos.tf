resource "github_repository" "this" {
  for_each = var.repos

  name         = each.key
  description  = each.value.description
  topics       = each.value.topics
  homepage_url = each.value.homepage
  visibility   = var.visibility

  has_issues   = true
  has_projects = false
  has_wiki     = false

  # Squash-only keeps main history linear and one commit per PR.
  allow_merge_commit     = false
  allow_rebase_merge     = false
  allow_squash_merge     = true
  delete_branch_on_merge = true

  # Creates main so branch protection has something to attach to.
  auto_init = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository_vulnerability_alerts" "this" {
  for_each = github_repository.this

  repository = each.value.name
}

resource "github_branch_protection" "main" {
  # Free plan only supports branch protection on public repos.
  for_each = var.visibility == "public" ? github_repository.this : {}

  repository_id = each.value.node_id
  pattern       = "main"

  # Solo maintainer for now: require PRs but no approvals, and let admins bypass.
  enforce_admins          = false
  required_linear_history = true
  allows_force_pushes     = false
  allows_deletions        = false

  required_pull_request_reviews {
    required_approving_review_count = 0
  }
}
