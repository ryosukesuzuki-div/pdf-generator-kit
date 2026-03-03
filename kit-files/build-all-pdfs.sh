#!/bin/bash

# 全てのMarkdownファイルを個別のPDFとして出力するスクリプト

# 出力先ディレクトリが存在しない場合は作成
mkdir -p dist/pdf

echo "PDFの個別出力を開始します..."

# pck-articles内のすべての.mdファイルを検索してループ処理
find pck-articles -name "*.md" | while read -r file; do
    # パスからファイル名（拡張子なし）を取り出す
    # 例: pck-articles/pck-sec1/Sec1_チャプター1.md -> Sec1_チャプター1
    filename=$(basename "$file" .md)
    
    # セクション名をディレクトリパスから取り出す（任意：出力先の整理用）
    # 例: pck-Articles/pck-sec1 -> pck-sec1
    section_dir=$(dirname "$file" | basename)
    
    echo "処理中: $file -> dist/pdf/${filename}.pdf"
    
    # スクリプトの場所を基準とした絶対パスでデザインを指定
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
    THEME_PATH="$SCRIPT_DIR/styles/style.css"

    # vivliostyle CLI を使って単一のMarkdownをPDFに変換
    # --theme オプションでプロジェクトのスタイルを適用
    npx vivliostyle build "$file" \
      --theme "$THEME_PATH" \
      --output "dist/pdf/${filename}.pdf"
done

echo "全ての出力が完了しました！ PDFは dist/pdf/ フォルダに保存されています。"
