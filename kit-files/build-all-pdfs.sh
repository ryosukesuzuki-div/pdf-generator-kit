#!/bin/bash

# 指定したフォルダ内のMarkdownファイルを全て個別のPDFとして出力するスクリプト

# スクリプトのディレクトリに移動（VivliostyleのCSSパス解決起点を固定するため）
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# 対象フォルダを引数で受け取る（省略時は articles を使用）
TARGET_DIR="${1:-articles}"

# 対象フォルダが存在するか確認
if [ ! -d "$TARGET_DIR" ]; then
    echo "エラー: 指定されたフォルダが見つかりません -> $TARGET_DIR"
    echo "使い方: npm run pdf:all [フォルダ名]"
    echo "例:     npm run pdf:all articles"
    echo "例:     npm run pdf:all my-manuscripts"
    exit 1
fi

# 出力先ディレクトリが存在しない場合は作成
mkdir -p dist/pdf

echo "対象フォルダ: $TARGET_DIR"
echo "PDFの一括出力を開始します..."

# 対象フォルダ内のすべての .md ファイルを検索してループ処理
find "$TARGET_DIR" -name "*.md" | sort | while read -r file; do

    filename=$(basename "$file" .md)
    OUTPUT_FILE="dist/pdf/${filename}.pdf"

    echo "処理中: $file -> $OUTPUT_FILE"

    # 一時的な vivliostyle config を生成してビルド
    # （entry に相対パスを使うことで styles/ の誤コピーを防ぐ）
    TEMP_CONFIG="vivliostyle.tmp.config.js"
    cat > "$TEMP_CONFIG" <<EOF
module.exports = {
  language: 'ja',
  size: 'A4',
  theme: './styles/style.css',
  entry: [
    '${file}'
  ],
  output: [
    './${OUTPUT_FILE}'
  ],
};
EOF

    npx vivliostyle build --config "$TEMP_CONFIG"
    rm -f "$TEMP_CONFIG"

done

echo "全ての出力が完了しました！ PDFは dist/pdf/ フォルダに保存されています。"
