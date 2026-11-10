FROM rocker/tidyverse:latest

## User
ARG USERNAME=user
ARG USER_UID=1000

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    sudo \
    curl \
    git \
    ripgrep \
    cmake \
    libcurl4-openssl-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libicu-dev \
    libnode-dev \
    libpng-dev \
    libssl-dev \
    libx11-dev \
    libxml2-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    gnuplot \
    ghostscript \
    fonts-noto-cjk \
    fonts-ipaexfont \
    libtiff5-dev \
    libjpeg-dev \
    xz-utils \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*


USER $USERNAME
WORKDIR /home/$USERNAME

# uvをインストール
RUN curl -LsSf https://astral.sh/uv/install.sh | sh


