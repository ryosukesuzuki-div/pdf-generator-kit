#!/bin/bash

# PDF教材制作キット：セットアップスクリプト
# このスクリプトは、キット内の資材を一階層上（プロジェクトのルート）に展開します。

echo "PDF教材制作キットのセットアップを開始します（展開先：一階層上のフォルダ）"

# スクリプトが置かれているディレクトリを取得
KIT_DIR="$(cd "$(dirname "$0")" && pwd)"
# 展開先（プロジェクトのルート）
DEST_DIR="$(dirname "$KIT_DIR")"

cd "$DEST_DIR"

# 1. 必要なディレクトリの作成
echo "ディレクトリを作成中..."
mkdir -p styles dist/pdf articles/images

# 2. キット内の kit-files フォルダから資材を外側（プロジェクトルート）へ展開
echo "制作資材を展開しています..."
cp "$KIT_DIR/kit-files/package.json" ./package.json
cp "$KIT_DIR/kit-files/styles/style.css" ./styles/style.css
cp "$KIT_DIR/kit-files/build-single-pdf.sh" ./build-single-pdf.sh
cp "$KIT_DIR/kit-files/build-all-pdfs.sh" ./build-all-pdfs.sh
cp "$KIT_DIR/kit-files/vivliostyle.book.config.js" ./vivliostyle.book.config.js
# サンプル原稿と画像フォルダを articles フォルダに展開
cp -r "$KIT_DIR/kit-files/articles/" ./articles/

# 3. AIスキル定義（SKILL.md）の展開先を決定
# 優先順位: .agent > .agents > .claude (いずれもなければ .agent を作成)
SKILL_BASE_DIR=""
if [ -d "./.agent" ]; then
    SKILL_BASE_DIR="./.agent"
elif [ -d "./.agents" ]; then
    SKILL_BASE_DIR="./.agents"
elif [ -d "./.claude" ]; then
    SKILL_BASE_DIR="./.claude"
else
    SKILL_BASE_DIR="./.agent"
    mkdir -p "$SKILL_BASE_DIR"
fi

SKILL_DEST="$SKILL_BASE_DIR/skills/pdf-generator"
mkdir -p "$SKILL_DEST"

# AIスキル定義をコピー
cp "$KIT_DIR/kit-files/.agent/skills/pdf-generator/SKILL.md" "$SKILL_DEST/SKILL.md"

# 4. 使用方法ドキュメントをルートに展開
cp "$KIT_DIR/PDF教材制作キットの使い方.md" ./PDF教材制作キットの使い方.md

# 5. 実行権限の付与
chmod +x build-single-pdf.sh build-all-pdfs.sh

# 6. ツールのインストール
echo "ツールをダウンロードしています（しばらくお待ちください）"
npm install

# 7. キットフォルダの隠しフォルダ化
# セットアップ完了後、このフォルダ自体を隠しフォルダにしてルートを整理します
if [[ "$(basename "$KIT_DIR")" == pdf-generator-kit* ]]; then
    if [ ! -d "$DEST_DIR/.pdf-generator-kit" ]; then
        echo ""
        echo "フォルダを整理しています..."
        mv "$KIT_DIR" "$DEST_DIR/.pdf-generator-kit"
        echo "※ 元のキットフォルダは '.pdf-generator-kit' に移動（隠しフォルダ化）されました"
    fi
fi

# 8. 展開先のGitリポジトリを初期化（キット由来の.gitを除去して新規init）
# クローン時に付属してくるキット開発用の.gitを削除し、ユーザーのプロジェクトとして再初期化する
if [ -d "$DEST_DIR/.git" ]; then
    echo ""
    echo "Gitリポジトリを初期化しています（キット由来の履歴を除去）..."
    rm -rf "$DEST_DIR/.git"
    git -C "$DEST_DIR" init -q
    echo "✔ Gitリポジトリを新規初期化しました"
fi

echo ""
echo "セットアップが完了しました"
echo "--------------------------------------------------"
echo "今後の執筆フロー："
echo ""
echo "1. articles/SAMPLE.md をコピーして新しい原稿を作成します"
echo "2. プロジェクトルートにある『PDF教材制作キットの使い方.md』を参考に執筆します"
echo "3. 以下のコマンドを実行して PDF に変換します"
echo ""
echo "   # 1ファイルをPDF化（ファイルのパスを指定）"
echo "   npm run pdf articles/SAMPLE.md"
echo ""
echo "   # フォルダ内を一括PDF化（フォルダ名を指定・省略時はarticles/）"
echo "   npm run pdf:all"
echo "--------------------------------------------------"
echo "[AIスキル] SKILL.md を $SKILL_BASE_DIR/skills/pdf-generator/ に配置しました"
echo "※ AIへの相談時は「このプロジェクトの執筆ルールを教えて」などと伝えてください"
