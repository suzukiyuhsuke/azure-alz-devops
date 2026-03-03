// team.tf

// チーム機能が有効な場合のみチームを作成
resource "github_team" "this" {
  for_each    = local.teams_enabled ? var.teams : {}
  name        = each.key
  description = each.value.description
  privacy     = "closed"
}

// チーム機能が有効な場合のみチームとリポジトリを関連付け
resource "github_team_repository" "this" {
  for_each   = local.teams_enabled ? var.teams : {}
  team_id    = github_team.this[each.key].id
  repository = github_repository.this.name
  permission = each.value.permission

  depends_on = [
    github_team.this,
    github_repository.this,
  ]
}
