// data.tf

locals {
  // 個人アカウントか組織かを制御するフラグ
  is_organization = var.organization_name != ""
  free_plan       = "free"
}

// 組織名が指定されている場合のみ組織データを取得
data "github_organization" "this" {
  count = local.is_organization ? 1 : 0
  name  = var.organization_name
}

// 個人アカウント用のデフォルト値を設定
locals {
  // 組織または個人アカウントのプラン（組織がない場合はfreeとみなす）
  plan = local.is_organization ? data.github_organization.this[0].plan : local.free_plan
}
