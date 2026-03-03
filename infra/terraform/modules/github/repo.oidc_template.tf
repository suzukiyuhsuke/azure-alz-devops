// repo.oidc_template.tf

# resource "github_actions_repository_oidc_subject_claim_customization_template" "this" {
#   repository  = github_repository.this.name
#   use_default = false
#   include_claim_keys = [
#     "repository",
#     "environment",
#     #"job_workflow_ref"
#   ]

#   depends_on = [
#     github_repository.this,
#   ]
# }

locals {
  // 個人アカウントの場合はgithub_usernameパラメータを使用
  // organization_nameが空の場合、github_usernameを使用
  // github_usernameも空の場合はエラーになるが、変数のvalidationで既にチェックされているはず
  repo_owner = var.organization_name != "" ? var.organization_name : var.github_username

  oidc_fedarations = {
    for env_key, env in var.environments : env_key => {
      org     = local.repo_owner
      repo    = var.main_repository_name
      issuer  = "https://token.actions.githubusercontent.com"
      prefix  = "sc-github-${local.repo_owner}-${var.main_repository_name}",
      subject = "repo:${local.repo_owner}/${var.main_repository_name}:environment:${env.name}"
    }
  }
}
