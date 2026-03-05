<div class="doc-header">pdf-generator-kit</div>
<div class="doc-title">PDF生成キットの使い方</div>
<div class="doc-subtitle">Markdownからプロ仕様のPDFを出力するキット</div>

# PDF生成キットの使い方

このキットをセットアップすると、Markdown原稿をプロ仕様のPDFに変換できるようになります。
以下の **1〜4 のステップ** を順に進めてください。

---

## 1. PDF生成キットをセットアップする

まずは、自分のプロジェクトにこのキットを組み込みます。

1. **キットを配置する**
   原稿（.md ファイル）が置かれている一番上のフォルダ（プロジェクトルート）で、以下のコマンドを実行します。

   ```bash
   git clone https://github.com/ryosukesuzuki-div/pdf-generator-kit.git
   ```

   ```text
   自分のプロジェクトルートフォルダ/
     ├── (自分の原稿ファイルなど)
     └── pdf-generator-kit/
   ```

2. **セットアップを実行する**
   ターミナルで以下のコマンドを実行します。

   ```bash
   bash pdf-generator-kit/setup.sh
   ```

3. **完了を待つ**
   必要な設定や資材がプロジェクトルートに自動展開されます。既存のファイルを壊すことはありません。

   <div class="column-box">
   <div class="column-title">補足</div>

   セットアップ完了後、この `pdf-generator-kit` フォルダは自動的に **`.pdf-generator-kit`** にリネームされます。名前が `.` から始まるため、VS Code などのエディタ上では非表示になりますが、中身は削除されずに残っています。
   </div>

---

## 2. 動作を確認する（サンプルのPDF生成）

セットアップが正しくできたか、付属のサンプル（`articles/SAMPLE.md`）を使って確認してみましょう。
このサンプルは、「執筆マニュアル」兼「デザイン見本」兼「テンプレート」です。

1. **変換コマンドを実行する**
   ターミナルで以下のコマンドを入力して Enter を押してください。

   ```bash
   npm run pdf articles/SAMPLE.md
   ```

2. **PDFを確認する**
   新しく作られた `dist/pdf/` フォルダの中に、`SAMPLE.pdf` が出来ていれば成功です！

   <div class="column-box">
   <div class="column-title">補足：「dist」とは？</div>

   「Distribution（ディストリビューション＝配布、配布物）」の略称です。ITの世界では、変換が終わった「完成品（配布できる状態のもの）」を入れるフォルダとしてよく使われる慣習的な名前です。
   </div>

   ```text
   自分のプロジェクトルートフォルダ/
     └── dist/ (配布用・完成品の置き場所)
         └── pdf/
             └── SAMPLE.pdf  <-- ここに出力される
   ```

3. **SAMPLE.pdf を開く**
   `dist/pdf/SAMPLE.pdf` をダブルクリックするなど、開き方は適宜で構いません。

   開いた `SAMPLE.pdf` は、**3つの役割**を兼ねています。

   | 役割 | 説明 |
   |---|---|
   | ├ **執筆マニュアル** | SAMPLE.md と照らし合わせると、Markdownの記法とPDFの見た目の対応が分かる |
   | ├ **デザイン見本** | このキットでどんなPDFが作れるかがわかる |
   | └ **テンプレート** | SAMPLE.md をコピーして書き始めるだけですぐ執筆できる |

   <div class="column-box">
   <div class="column-title">ヒント</div>

   次の「原稿を執筆する」コーナーでも参照するので、開いたままにしておいてください。
   </div>

<div class="column-box">
<div class="column-title">ヒント</div>

慣れてきたら、いま読んでいるマニュアル自体（PDF生成キットの使い方.md）もPDFにしてみましょう。ターミナルで `npm run pdf PDF生成キットの使い方.md` を実行すると、このファイルも見やすいPDFになります。
</div>

---

## 3. 原稿ファイルの置き場所を決める

執筆する原稿（.md ファイル）の置き場所には、大きく分けて2つのパターンがあります。

### パターンA：【推奨】標準の場所で書く
キットに最初から用意されている `articles/` フォルダの中に原稿を作成します。
*   **メリット:** すでにあるサンプル（SAMPLE.md）や画像フォルダ（images/）の構成をそのまま真似できるので迷いません。
*   **実行方法:** `npm run pdf articles/my-article.md`

```text
自分のプロジェクトルートフォルダ/
  └── articles/
       ├── SAMPLE.md
       ├── my-article.md　(自分の原稿)
       └── images/  <--- 最初から用意されています
            └── sample-image.png
            └── my-image.png　(自分の画像)

```

### パターンB：好きな場所（フォルダ）で書く
プロジェクト内の好きな場所にフォルダを作って管理することも可能です。
*   **ルール:** 画像を使う場合は、その原稿ファイルと同じ場所に `images/` フォルダを自分で作り、その中に画像を保存してください。
*   **実行方法:** `npm run pdf フォルダ名/my-article.md`

```text
自分のプロジェクトルートフォルダ/
  └── my-folder/ (自分で作ったフォルダ)
       ├── my-article.md　(自分の原稿)
       └── images/  <--- 自分で作成してください
            └── my-image.png　(自分の画像)
```

---

## 4. 原稿を執筆する

### かんたんな執筆マニュアルについて

このキットの**執筆マニュアルは `articles/SAMPLE.md` そのもの**です。
Markdownの正しい記法、見出しの展開方法、コラムブロックの使い方など、具体的な記法ルールは上記ファイルに譲ります。

### 執筆を始める前のアクション

1.  **`SAMPLE.md` と `SAMPLE.pdf` を並べて、文書構造をイメージする**
    先ほど開いた `SAMPLE.pdf` を見ながら、`articles/SAMPLE.md` をエディタで開いてみましょう。
    「Markdownの記述→PDFの見た目」の対応が直感的に理解できます。
    「自分の原稿はどのような構造にしたいか」をこの段階で決めておくと、執筆がスムーズに進みます。

2.  **`SAMPLE.md` をコピーして、自分の原稿ファイルを作る**
    テンプレートとして活用できます。

    ```bash
    # 例：articles/内にコピーする場合
    cp articles/SAMPLE.md articles/my-article.md
    ```
    コピーしたファイルの内容を書き換えるだけで、すぐに執筆を始められます。

3.  **具体的な記法は `SAMPLE.pdf` を見ながら `SAMPLE.md` で確認**
    「こんな見た目にしたい」と思ったときは、SAMPLE.pdfで詳細に説明されています。
    困ったときはAIに「SAMPLE.mdを読んで」と伝えれば、キットのルールを把握したサポートを受けられます。

---

## 5. PDFを完成させる

原稿が書けたら、コマンドを実行してPDFに変換します。
コマンドは **2種類** あります。用途に合わせて使い分けてください。

### コマンドの全体像

| | 用途 | コマンド | 指定するもの |
|---|---|---|---|
| **シングル変換** | 1ファイルだけPDFにする | `npm run pdf ファイルパス` | ファイルへのパス |
| **一括変換** | フォルダ内を全部まとめてPDFにする | `npm run pdf:all フォルダ名` | フォルダの名前 |

<div class="column-box">
<div class="column-title">重要</div>

シングル変換は「**ファイルのパス**」、一括変換は「**フォルダの名前**」を指定します。この違いだけ覚えておけば大丈夫です！
</div>

出力先はどちらも常に `dist/pdf/` フォルダです。

---

### シングル変換（1ファイルだけPDFにする）

```bash
npm run pdf articles/SAMPLE.md
npm run pdf my-folder/my-article.md
```

- `npm run pdf` の後ろに、**プロジェクトルートから見たファイルのパス**を指定します。
- パスは `/`（スラッシュ）でフォルダとファイルをつないで書きます。

<div class="column-box">
<div class="column-title">ヒント：パスを簡単に入力する方法</div>

エクスプローラーでPDFにしたいファイルを**右クリック** →「**相対パスをコピー**」→ ターミナルに貼り付け（Cmd+V / Ctrl+V）
</div>

---

### 一括変換（フォルダごとまとめてPDFにする）

```bash
npm run pdf:all
npm run pdf:all articles
npm run pdf:all my-folder
```

- `npm run pdf:all` の後ろに、**フォルダの名前だけ**を指定します（パスではなく名前のみ）。
- **フォルダ名を省略すると、デフォルトの原稿フォルダ `articles/` が自動で対象になります。**
- 指定フォルダ内の `.md` ファイルが全てまとめてPDF化されます。

---

### コマンドはどこから実行してもOK

本キットは、プロジェクト内の**どのフォルダ（階層）から実行しても正しく動作します。**
階層を気にせず、そのままコマンドを入力して大丈夫です。

<div class="column-box">
<div class="column-title">ヒント：今いる場所（フォルダ）を確認するには？</div>

- ターミナルの入力欄のすぐ左にフォルダ名が表示されています。
- `pwd` と打って Enter を押すと、現在地がフルパスで表示されます。
</div>

---

## こだわり調整（カスタマイズ）

プロジェクトに合わせてデザインを変えたい場合は、**ルートにある** `styles/style.css` を編集します。
- `root` 部分の数値を書き換えるだけで、テーマカラーを一括変更できます。
- フォントの種類やサイズもこのファイルで自由に変更可能です。

---

## AIアシスタントへの指示

制作中にAIに相談する場合は、以下のように伝えてください。
> 「このプロジェクトの制作ルール（SKILL.md）を教えて」

キットが展開した `SKILL.md` をAIが読み込むことで、このキット特有のルールに基づいた的確なサポートを受けることができます。

<div class="column-box">
<div class="column-title">補足：AIスキルの展開場所について</div>

セットアップ時に、プロジェクトに既存のAIエージェント設定フォルダがある場合はその中に `SKILL.md` を追加します。

- `.agent/` がある場合 → `.agent/skills/pdf-generator/SKILL.md`
- `.agents/` がある場合 → `.agents/skills/pdf-generator/SKILL.md`
- `.claude/` がある場合 → `.claude/skills/pdf-generator/SKILL.md`
- いずれもない場合 → `.agent/` フォルダを新規作成して展開します。

セットアップ完了メッセージに展開先が表示されるので、ご確認ください。
</div>
