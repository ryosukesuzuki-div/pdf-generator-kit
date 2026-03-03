#!/bin/bash

# PDF制作キット：セットアップスクリプト
# このスクリプトは、キット内の資材を一階層上（プロジェクトのルート）に展開します。

echo "PDF制作キットのセットアップを開始します（展開先：一階層上のフォルダ）"

# スクリプトが置かれているディレクトリを取得
KIT_DIR="$(cd "$(dirname "$0")" && pwd)"
# 展開先（プロジェクトのルート）
DEST_DIR="$(dirname "$KIT_DIR")"

cd "$DEST_DIR"

# 1. 必要なディレクトリの作成
echo "ディレクトリを作成中..."
mkdir -p styles dist/pdf articles/images .agents/skills/pdf-generator

# 2. キット内の kit-files フォルダから資材を外側（プロジェクトルート）へ展開
echo "制作資材を展開しています..."
cp "$KIT_DIR/kit-files/package.json" ./package.json
cp "$KIT_DIR/kit-files/styles/style.css" ./styles/style.css
cp "$KIT_DIR/kit-files/build-single-pdf.sh" ./build-single-pdf.sh
cp "$KIT_DIR/kit-files/build-all-pdfs.sh" ./build-all-pdfs.sh
cp "$KIT_DIR/kit-files/vivliostyle.book.config.js" ./vivliostyle.book.config.js
# サンプル原稿と画像フォルダを articles フォルダに展開
cp -r "$KIT_DIR/kit-files/articles/" ./articles/
# AIスキル定義を展開
cp "$KIT_DIR/kit-files/.agents/skills/pdf-generator/SKILL.md" ./.agents/skills/pdf-generator/SKILL.md

# 3. 実行権限の付与
chmod +x build-single-pdf.sh build-all-pdfs.sh

# 4. ツールのインストール
echo "ツールをダウンロードしています（しばらくお待ちください）"
npm install

echo ""
echo "セットアップが完了しました"
echo "--------------------------------------------------"
echo "今後の執筆フロー："
echo ""
echo "1. articles/SAMPLE.md をコピーして新しい原稿を作成します"
echo "2. キット内の このキットの使用方法.md を参考に執筆します"
echo "3. 以下のコマンドを実行して PDF に変換します"
echo ""
echo "   npm run pdf [ファイルのパス]"
echo "--------------------------------------------------"
echo "※ AIへの相談時は「SKILL.md（制作ルール）を教えて」と伝えてください"
