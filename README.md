# RStudioとLatexの研究環境

RStudioとLatex環境 (tinytex)のDockerコンテナ。ベースイメージはrocker/rstudio。rockerプロジェクトには，tidyverseやLatex環境導入済みのイメージもあるが，柔軟にカスタマイズできるようにrocker/rstudioをベースにした。


## コンテナの内容

- ベースイメージはrocker/rstudio
- 追加したもの
  - tidyverseとsfをインストールするのに必要なパッケージ
  - Gnuplot
  - Ghostsctipt
  - IPAフォント，Notoフォント
  - [Pandoc-crosreff](https://github.com/lierdakil/pandoc-crossref)
  - RStudioでgithub copilotを利用可能に

## 導入方法

詳細は![こちら](https://tomokazu518.github.io/public/R_install.html)を参照。

最初にdocker volumeを2つ作成。

```sh
docker volume create cache
docker volume create bin
```

その後，Dockerfileをビルド。

```sh
docker build --rm -f "Dockerfile" -t researchenv:latest "."
```

docker composeを使ってコンテナを起動。

```sh
docker compose up -d
```

コンテナのシェルで初期設定スクリプトを実行

```
.config/init.sh
```

### マウントされるフォルダ

以下のフォルダはコンテナ終了後も内容が保持される。他の場所に保存したものはコンテナ終了時に消えてしまうので，保存が必要なものは以下の場所に保存する。

- `.config`: rstudioの設定など。
- `project`: コードやデータなど。プロジェクトごとにサブフォルダを作成して使うことを想定している。
- `.ssh`: sshの設定，鍵。
- `cache`: docker volume。追加でインストールしたパッケージのバイナリなど。
- `bin`: docker volume。実行ファイルのシンボリックなど。

### Python

pipxでpythonのパッケージをインストールできる。
- 実体は/home/rstudio/.cache/pipxに，実行ファイルのシンボリックリンクが`/home/rstudio/bin`にインストールされる。

### Visual Studio Codeで使う

Latexやquartoのソース編集などは，RStudioよりもVScodeの方が良い場合もある。VScodeをコンテナにアタッチして使うときには，ファイルのパーミションの問題 (とくにWindows)があるので，コンテナにはrstudioユーザーで入る。コンテナ構成ファイルに以下を追加すれば良い。
  ```
	"remoteUser": "rstudio"
  ```

## 参考

- Yanagimotoさんの[VSCode + Dockerでよりミニマルでポータブルな研究環境を](https://zenn.dev/nicetak/articles/vscode-docker-2023)，[VSCode + Docker + Rstudio + DVC でポータブルな研究環境を作る](https://zenn.dev/nicetak/articles/vscode-docker-rstudio?redirected=1)
- yetanothersuさんの[RStudio Serverで好きなフォントを使う](https://qiita.com/yetanothersu/items/18e098989cade90ee687)