# LINEAR インターン用 Brewfile
# キッティング時に管理者アカウント（村上）で実行する。インターン（標準ユーザー）は実行しない。
# 前提: Xcode Command Line Tools と Homebrew を管理者が手で入れ、PATH を通しておく
#   （手順は iknow「LINEAR 開発環境構築」No.6）
# 実行:
#   brew trust linear-dev/tools
#   brew trust dominion525/tap
#   curl -fsSL https://raw.githubusercontent.com/linear-dev/mac-kitting/main/Brewfile -o ~/Brewfile
#   brew bundle --file=~/Brewfile

# ---- tap ----
tap "linear-dev/tools"            # → https://github.com/linear-dev/homebrew-tools
tap "dominion525/tap"             # ⌘英かな 作者の公式 tap

# ---- 開発基盤 ----
brew "git"                        # CLT にも git はあるが、Homebrew 版で新しい版を使う
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

# ---- AI ----
cask "claude"                     # Claude デスクトップアプリ（会社契約シートでログイン）
cask "claude-code"                # Claude Code（ターミナル）。更新は管理者の brew upgrade

# ---- DB クライアント ----
cask "tableplus"

# ---- ユーティリティ ----
cask "raycast"                    # ランチャー
