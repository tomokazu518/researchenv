# RStudioとLatexの研究環境

RStudioとLatex環境 (tinytex)のDockerコンテナ。ベースイメージはrocker/rstudio。rockerプロジェクトには，tidyverseやLatex環境導入済みのイメージもあるが，柔軟にカスタマイズできるようにrocker/rstudioをベースにした。


## コンテナの内容

- ベースイメージrocker/rstudioに含まれているもの
  - R本体
  - RStudio Server
  - Pandoc
- 追加したもの
  - tidyverseとsfをインストールするのに必要なパッケージ
  - RStudioでgithub copilotを利用可能に
  - Gnuplot
  - Ghostsctipt
  - IPAフォント，Notoフォント
  - [Pandoc-crosreff](https://github.com/lierdakil/pandoc-crossref)

## 導入方法

![こちら](https://tomokazu518.github.io/public/R_install.html)を参照。

### 基本的な使い方

researchenvフォルダはホームフォルダ(/home/rstudio)としてマウントされるので，その中に`projects`というサブ・フォルダを作成し，さらにその中でプロジェクトごとのサブフォルダを作って使うことを想定している

### Python

pipxでpythonのパッケージをインストールできる
- ~/.local/binにインストールされる

### Visual Studio Codeで使う

Latexやquartoのソース編集などは，RStudioよりもVScodeの方が良い場合もある。VScodeをコンテナにアタッチして使うときには，ファイルのパーミションの問題 (とくにWindows)があるので，コンテナにはrstudioユーザーで入る。コンテナ構成ファイルに以下を追加すれば良い。
  ```
	"remoteUser": "rstudio"
  ```

## 参考

- Yanagimotoさんの[VSCode + Dockerでよりミニマルでポータブルな研究環境を](https://zenn.dev/nicetak/articles/vscode-docker-2023)，[VSCode + Docker + Rstudio + DVC でポータブルな研究環境を作る](https://zenn.dev/nicetak/articles/vscode-docker-rstudio?redirected=1)
- yetanothersuさんの[RStudio Serverで好きなフォントを使う](https://qiita.com/yetanothersu/items/18e098989cade90ee687)