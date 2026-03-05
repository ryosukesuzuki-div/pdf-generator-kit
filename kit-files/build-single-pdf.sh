#!/bin/bash

# 指定した1つのMarkdownファイルだけをPDFに出力するスクリプト

if [ -z "$1" ]; then
    echo "エラー: Markdownファイルが指定されていません。"
    echo "使い方: npm run pdf -- <mdファイルへのパス>"
    exit 1
fi

# スクリプトのディレクトリを取得し、そこをカレントディレクトリにする
# （Vivliostyleがstyles/を解決する起点をkit-files/に固定するため）
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# 入力ファイルの絶対パスを求める
# 引数が絶対パスならそのまま、相対パスなら元のカレントディレクトリ基点で解決
if [[ "$1" = /* ]]; then
    INPUT_ABS="$1"
else
    INPUT_ABS="$(cd "$OLDPWD" && cd "$(dirname "$1")" && pwd)/$(basename "$1")"
fi

# ファイルが存在するか確認
if [ ! -f "$INPUT_ABS" ]; then
    echo "エラー: 指定されたファイルが見つかりません -> $INPUT_ABS"
    exit 1
fi

# 入力ファイルをSCRIPT_DIR基点の相対パスに変換（Vivliostyle configのentryに使用）
INPUT_REL=$(python3 -c "import os.path; print(os.path.relpath('$INPUT_ABS', '$SCRIPT_DIR'))")

# 出力先ディレクトリが存在しない場合は作成
mkdir -p dist/pdf

# パスからファイル名（拡張子なし）を取り出す
filename=$(basename "$INPUT_ABS" .md)
OUTPUT_FILE="dist/pdf/${filename}.pdf"

echo "単独PDF出力処理を開始します: $INPUT_ABS -> $OUTPUT_FILE"

# 一時的な vivliostyle config を生成
# entryはSCRIPT_DIR基点の相対パスで指定→styleのコピーもSCRIPT_DIR内に留まる
TEMP_CONFIG="vivliostyle.tmp.config.js"
cat > "$TEMP_CONFIG" <<EOF
module.exports = {
  language: 'ja',
  size: 'A4',
  theme: './styles/style.css',
  entry: [
    './${INPUT_REL}'
  ],
  output: [
    './${OUTPUT_FILE}'
  ],
};
EOF

# vivliostyle CLI を使ってPDFに変換（config経由で実行）
npx vivliostyle build --config "$TEMP_CONFIG"
BUILD_EXIT=$?

# 一時configを削除
rm -f "$TEMP_CONFIG"

if [ $BUILD_EXIT -eq 0 ]; then
    echo "完了しました！ PDFを確認してください: $OUTPUT_FILE"
else
    echo "エラー: PDF生成に失敗しました。"
    exit $BUILD_EXIT
fi
