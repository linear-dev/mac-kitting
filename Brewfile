# LINEAR インターン用 Brewfile
# キッティング時に管理者アカウント（村上）で実行する。インターン（標準ユーザー）は実行しない。
# 実行（tap より先に git が必要なので 2 行に分ける）:
#   brew install git
#   brew bundle --file=/Users/Shared/linear/Brewfile
#
# 前提（MDM でプリイン済み）: Homebrew
# Xcode Command Line Tools は入れない（git は Homebrew 版を使う）

# ---- tap ----
tap "linear-dev/tools"            # → https://github.com/linear-dev/homebrew-tools
tap "dominion525/tap"             # ⌘英かな 作者の公式 tap

# ---- 開発基盤 ----
brew "git"                        # bundle の前に単独で入れるが、管理対象として明記
cask "docker-desktop"             # 標準環境（docker / compose / buildx を同梱）
brew "linear-dev/tools/tug"       # ポート衝突を避けて複数案件を起動
brew "composer"                   # PHP のパッケージ管理（必須。PHP も一緒に入る）
brew "gh"                         # GitHub CLI
brew "lefthook"                   # Git フック
cask "fork"                       # Git クライアント
cask "dominion525/tap/cmd-eikana" # ⌘ 単押しで英数/かな切替

# ---- コミュニケーション・ブラウザ ----
cask "microsoft-teams"            # インストール時に管理者パスワードが必要
cask "microsoft-edge"
cask "google-chrome"

# ---- エディタ ----
cask "cursor"

# ---- DB クライアント ----
cask "tableplus"

# ---- ユーティリティ ----
cask "raycast"                    # ランチャー
