# TexLiveのレポジトリをダウンロードしてからビルドする場合

FROM rocker/rstudio:latest

ARG TARGETARCH
WORKDIR /work

# 必要なパッケージのインストール
RUN apt update && apt upgrade -y &&  \
    apt install -y \
      # tidyverse に必要
      zlib1g-dev \
      libxml2-dev \
      libcurl4-openssl-dev \
      libfontconfig1-dev \
      libharfbuzz-dev  \
      libfribidi-dev \
      libfreetype6-dev \
      libpng-dev \
      libtiff5-dev \
      libjpeg-dev \
      libx11-dev \
      # sf に必要
      libudunits2-dev \
      libgdal-dev \
      gdal-bin \
      # fonts
      fonts-ipafont \
      fonts-ipaexfont \
      fonts-noto-cjk \
      # tools
      gnuplot \
      ghostscript \
      # other
      cmake \
      openssh-client \
      curl \
      xz-utils \
      pipx && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Pandocフィルターのインストール
## pandoc-crossref
RUN wget "https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.20/pandoc-crossref-Linux-X64.tar.xz"
RUN tar xf pandoc-crossref-Linux-X64.tar.xz && \
    mv pandoc-crossref /usr/bin

## github copilot有効化
RUN echo "copilot-enabled=1" >> /etc/rstudio/rsession.conf

## クリーンアップ
RUN rm -rf /work
