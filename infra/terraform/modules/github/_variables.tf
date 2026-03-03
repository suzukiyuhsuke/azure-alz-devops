// _variables.tf

variable "organization_name" {
  description = "Name of the GitHub organization. 空の場合は個人アカウントとして扱われます。"
  type        = string
  default     = ""
}

variable "github_username" {
  description = "個人アカウントとして使用する場合のGitHubユーザー名。organization_nameが空の場合に使用されます。"
  type        = string
  default     = ""

  validation {
    // organization_nameが空でgithub_usernameも空の場合はエラー
    condition     = var.organization_name != "" || var.github_username != ""
    error_message = "github_username must be set when organization_name is empty."
  }
}

variable "organization_domain_name" {
  description = "Domain name of the GitHub organization"
  type        = string
  default     = "github.com"
}

variable "api_domain_name" {
  description = "Domain name of your GitHub API endpoint"
  type        = string
  default     = "api.github.com"
}
