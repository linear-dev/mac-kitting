#!/bin/zsh
# pkg 署名用の自前インストーラ ID を作成し、ログインキーチェーンに取り込む（有効期限 3 年）
# 手順は Apple Business ユーザガイド「アプリケーションのインストーラパッケージを作成する」に準拠
# 要件: macOS 13 以降
# 使い方: ./create-installer-id.sh [ID名]   （省略時は LINEAR）
set -euo pipefail

ID=${1:-LINEAR}
if [[ ! "$ID" =~ '^[A-Za-z0-9_-]+$' ]]; then
  echo "ID名は英数字・ハイフン・アンダースコアのみ使えます: '$ID'" >&2
  exit 1
fi
DAYS=1095   # 3 年
OUTDIR="$HOME/Desktop/installer-id-$ID"
CERT="InstallerCertificate_${ID}.pem"
KEY="InstallerCertificate_${ID}_PrivateKey.pem"

mkdir -p "$OUTDIR"
cd "$OUTDIR"

if [[ -e "$CERT" ]]; then
  echo "既に $OUTDIR/$CERT があります。作り直す場合は先に退避してください。" >&2
  exit 1
fi

# 1. 証明書と秘密鍵を作成
openssl req -x509 -nodes -days "$DAYS" -newkey rsa:4096 -sha256 \
  -addext basicConstraints=critical,CA:false \
  -addext keyUsage=critical,digitalSignature \
  -set_serial "0x$(openssl rand -hex 4)" \
  -subj "/CN=Installer Certificate ($ID)" \
  -out "$CERT" \
  -keyout "$KEY"

# 2. キーチェーンに取り込み、信頼設定（パスワードを求められます）
security import "$CERT"
security import "$KEY" -T /usr/bin/productbuild -T /usr/bin/pkgbuild
security add-trusted-cert -d "$CERT"

# 3. 秘密鍵ファイルを削除（キーチェーンに保存済み）
rm -f "$KEY"

echo
echo "完了: 署名ID名 = Installer Certificate ($ID)"
openssl x509 -in "$CERT" -noout -enddate | sed 's/notAfter=/有効期限: /'
echo
echo "保管するファイル（Apple Business の証明書構成に登録）:"
echo "  $OUTDIR/$CERT"
echo
echo "署名に使えるか確認:"
security find-identity -v -p basic | grep "Installer Certificate ($ID)" || echo "  見つかりません。キーチェーンアクセスで確認してください。"
