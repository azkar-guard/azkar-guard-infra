output "repo_urls" {
  description = "HTML URLs of managed repos."
  value       = { for name, repo in github_repository.this : name => repo.html_url }
}

output "repo_ssh_urls" {
  description = "SSH clone URLs of managed repos."
  value       = { for name, repo in github_repository.this : name => repo.ssh_clone_url }
}
