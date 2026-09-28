variable "org" {
  description = "GitHub organization that owns all Azkar Guard repos."
  type        = string
  default     = "azkar-guard"
}

variable "visibility" {
  description = "Repo visibility. Branch protection on the Free plan requires public, so it is skipped for private repos."
  type        = string
  default     = "public"

  validation {
    condition     = contains(["public", "private"], var.visibility)
    error_message = "visibility must be public or private."
  }
}

variable "repos" {
  description = "Repos managed in the org. Phase 4 (jetbrains) and 5 (mobile) are intentionally held back."
  type = map(object({
    description = string
    topics      = list(string)
    homepage    = optional(string, "")
  }))

  default = {
    "azkar-guard-infra" = {
      description = "Terraform for the azkar-guard GitHub org and repos."
      topics      = ["terraform", "github", "infrastructure"]
    }
    "azkar-guard-browser-extension" = {
      description = "Phase 1: Manifest V3 browser extension that enforces morning/evening Azkar completion."
      topics      = ["azkar", "browser-extension", "chrome-extension", "manifest-v3"]
      homepage    = "https://chromewebstore.google.com/detail/pphgcabpchgmnmpfchhgjcckdgmcjnic"
    }
    "azkar-guard-vscode-extension" = {
      description = "Phase 2: VS Code extension that enforces morning/evening Azkar completion."
      topics      = ["azkar", "vscode-extension", "open-vsx"]
      homepage    = "https://marketplace.visualstudio.com/items?itemName=azkar-guard.azkar-guard-vscode"
    }
    "azkar-guard-website" = {
      description = "Phase 3: dashboard for streaks, history and synced settings."
      topics      = ["azkar", "website"]
    }
    "azkar-guard-api" = {
      description = "Phase 3: Go API for accounts and cross-device sync of Azkar completion."
      topics      = ["azkar", "golang", "api"]
    }
  }
}
