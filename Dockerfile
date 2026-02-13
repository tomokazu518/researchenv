# TexLiveのレポジトリをダウンロードしてからビルドする場合

FROM rocker/rstudio:latest

ARG TARGETARCH
ENV TARGETARCH=${TARGETARCH}

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

RUN fc-cache -f -v

# Pandocのインストール
RUN case "$TARGETARCH" in \
        "amd64")  ARCH="amd64" ;; \
        "arm64")  ARCH="arm64" ;; \
    esac; \
    PANDOC_VERSION="3.9"; \
    wget https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-linux-${ARCH}.tar.gz ;\
    tar -xf pandoc-${PANDOC_VERSION}-linux-${ARCH}.tar.gz; \
    mv pandoc-${PANDOC_VERSION}/bin/* /usr/local/bin/; \
    rm -rf pandoc-${PANDOC_VERSION}*

# Pandoc-crossrefのインストール
RUN case "$TARGETARCH" in \
        "amd64")  ARCH="Linux-X64" ;; \
        "arm64")  ARCH="Linux-ARM64" ;; \
    esac; \
    VERSION="0.3.23a"; \
    wget https://github.com/lierdakil/pandoc-crossref/releases/download/v${VERSION}/pandoc-crossref-${ARCH}.tar.xz; \
    tar -xf pandoc-crossref-${ARCH}.tar.xz; \
    mv pandoc-crossref /usr/local/bin/; \
    chmod +x /usr/local/bin/pandoc-crossref; \
    rm pandoc-crossref-${ARCH}.tar.xz

## github copilot有効化
RUN echo "copilot-enabled=1" >> /etc/rstudio/rsession.conf

## クリーンアップ
RUN rm -rf /work