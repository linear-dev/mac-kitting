#!/bin/zsh
# Brewfile を /Users/Shared/linear/Brewfile に置く pkg を作る
# 使い方: ./build-brewfile-pkg.sh <Brewfile のパス> <バージョン> [署名ID名]
#   例:   ./build-brewfile-pkg.sh ./Brewfile 1.0.0 "Installer Certificate (LINEAR)"
set -euo pipefail

BREWFILE=${1:?Brewfile のパスを指定してください}
VERSION=${2:?バージョンを指定してください（例: 1.0.0）}
SIGN_ID=${3:-"Installer Certificate (LINEAR)"}

IDENTIFIER="dev.linear.brewfile"
# Apple Business の推奨: 英小文字・数字・ハイフンのみ、バージョンごとに別名
OUT="linear-brewfile-${VERSION//./-}.pkg"

WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT

mkdir -p "$WORK/root/Users/Shared/linear"
cp "$BREWFILE" "$WORK/root/Users/Shared/linear/Brewfile"
chmod 644 "$WORK/root/Users/Shared/linear/Brewfile"

pkgbuild \
  --root "$WORK/root" \
  --identifier "$IDENTIFIER" \
  --version "$VERSION" \
  --install-location / \
  "$WORK/component.pkg"

productbuild \
  --sign "$SIGN_ID" \
  --package "$WORK/component.pkg" \
  "$OUT"

echo "作成: $OUT"
echo "SHA-256（Apple Business に登録）:"
shasum -a 256 "$OUT" | awk '{print $1}'
