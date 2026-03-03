// _locals.tf

// Note: free_plan is now defined in data.tf

locals {
  // 個人アカウントの場合はユーザーページ、組織の場合は組織ページのURLを生成
  organization_url = var.organization_name != "" ? "https://${var.organization_domain_name}/${var.organization_name}" : "https://${var.organization_domain_name}"
  api_base_url     = "https://${var.api_domain_name}/"
}

locals {
  # default_branch = "refs/heads/main"
}

// 共通の条件判定ロジック
locals {
  // organization_nameが空でなく、かつチームが定義されている場合のみチーム機能を有効にする
  teams_enabled = var.organization_name != "" && length(var.teams) > 0
}
