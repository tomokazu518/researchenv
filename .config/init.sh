#!/bin/sh

# RStudio ServerにHackGenフォントをインストール
## HackGenフォントはコードを書くのに適したフォント
HACKGEN_VER="2.9.0"

mkdir -p /home/rstudio/.config/rstudio/fonts/temp
cd /home/rstudio/.config/rstudio/fonts/

# HackGen
    mkdir -p "HackGen/400"
    mkdir -p "HackGen/700"
    mkdir -p "HackGen Console/400"
    mkdir -p "HackGen Console/700"
    mkdir -p "HackGen35/400"
    mkdir -p "HackGen35/700"
    mkdir -p "HackGen35 Console/400"
    mkdir -p "HackGen35 Console/700"

if [ -e HackGen_v$HACKGEN_VER.zip ]; then
    echo "HackGen_v$HACKGEN_VER.zip found."

    else 
	wget https://github.com/yuru7/HackGen/releases/download/v$HACKGEN_VER/HackGen_v$HACKGEN_VER.zip

fi

    unzip HackGen_v$HACKGEN_VER.zip -d /home/rstudio/.config/rstudio/fonts/temp/

    mv temp/HackGen_v$HACKGEN_VER/HackGen-Regular.ttf HackGen/400
    mv temp/HackGen_v$HACKGEN_VER/HackGen-Bold.ttf HackGen/700
    mv temp/HackGen_v$HACKGEN_VER/HackGenConsole-Regular.ttf HackGen\ Console/400
    mv temp/HackGen_v$HACKGEN_VER/HackGenConsole-Bold.ttf HackGen\ Console/700
    mv temp/HackGen_v$HACKGEN_VER/HackGen35-Regular.ttf HackGen35/400
    mv temp/HackGen_v$HACKGEN_VER/HackGen35-Bold.ttf HackGen35/700
    mv temp/HackGen_v$HACKGEN_VER/HackGen35Console-Regular.ttf HackGen35\ Console/400
    mv temp/HackGen_v$HACKGEN_VER/HackGen35Console-Bold.ttf HackGen35\ Console/700

rm -r temp

# Python 関連
mkdir -p /home/rstudio/.cache/pipx/venvs

# Latex 関連

## tinytex (QuartoなどでPDFを作成する場合も必要)
R -e 'install.packages("tinytex")'
R -e 'tinytex::install_tinytex(dir = "/home/rstudio/.cache/.TinyTeX", force = TRUE)'

## texlive full install (使う場合のみ)
# tlmgr install scheme-full

## gnuplot-lua-tikz.sty (Latexにgnuplotのグラフを挿入したい場合は必要)
mkdir -p /home/rstudio/.cache/.TinyTeX/texmf-local/tex/latex/gnuplot
cd  /home/rstudio/.cache/.TinyTeX/texmf-local/tex/latex/gnuplot
gnuplot -e "set term tikz createstyle"
mktexlsr
