#!/bin/bash

# 指定した1つのMarkdownファイルだけをPDFに出力するスクリプト

if [ -z "$1" ]; then
    echo "エラー: Markdownファイルが指定されていません。"
    echo "使い方: npm run build:single ./pck-articles/pck-sec1/Sec1_チャプター1.md"
    exit 1
fi

INPUT_FILE="$1"

# ファイルが存在するか確認
if [ ! -f "$INPUT_FILE" ]; then
    echo "エラー: 指定されたファイルが見つかりません -> $INPUT_FILE"
    exit 1
fi

# 出力先ディレクトリが存在しない場合は作成
mkdir -p dist/pdf

# パスからファイル名（拡張子なし）を取り出す
filename=$(basename "$INPUT_FILE" .md)
OUTPUT_FILE="dist/pdf/${filename}.pdf"

echo "単独PDF出力処理を開始します: $INPUT_FILE -> $OUTPUT_FILE"

# スクリプトの場所を基準とした絶対パスでデザインを指定
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
THEME_PATH="$SCRIPT_DIR/styles/style.css"

# vivliostyle CLI を使って単一のMarkdownをPDFに変換
npx vivliostyle build "$INPUT_FILE" \
  --theme "$THEME_PATH" \
  --output "$OUTPUT_FILE"

echo "完了しました！ PDFを確認してください: $OUTPUT_FILE"
