// github.tf

module "github" {
  source = "../../modules/github"

  // Organizations - 空文字列の場合は個人アカウント、そうでなければ組織として扱われる
  organization_name = local.options.github.organization_name
  // 個人アカウントの場合のGitHubユーザー名（organization_nameが空の場合に使用）
  github_username   = var.github_username

  // Teams - organization_nameが空の場合、このパラメータは内部で無視される
  teams = module.workflow.teams

  // Repository
  main_repository_name       = local.repository_name
  main_repository_files      = module.workflow.workflow_main_files
  use_templates_repository   = var.use_templates_repository
  templates_repository_name  = local.templates_repository_name
  templates_repository_files = module.workflow.workflow_templates_files
  branch_rules               = module.workflow.branch_rules

  // Environments
  default_environments = module.workflow.default_github_environments
  environments         = local.github_environments

  // Variables
  variables = concat(
    local.tfstate_backend_variables,
    local.azure_subscription_variables,
    module.workflow.repo_variables
  )

  // GitHub Runners
  runner_group_name = local.runner_group_name
}
