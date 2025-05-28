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

# PATH (~/.local/binをPATHに追加)

printf "%s\n" \
  'export PATH=$PATH:/home/rstudio/.local/bin' \
  'export PATH=$(echo $PATH | awk -v RS=":" '\''!a[$1]++ { if (NR > 1) printf RS; printf $1 }'\'')' \
  > ~/.bashrc
echo "source ~/.bashrc" > ~/.bash_profile

# Latex 関連

## tinytex (QuartoなどでPDFを作成する場合も必要)
R -e 'install.packages("tinytex")'
R -e 'tinytex::install_tinytex(force = TRUE)'

## haranoaji font
~/.local/bin/tlmgr install haranoaji

## texcount
~/.local/bin/tlmgr install texcount
~/.local/bin/tlmgr path add

## gnuplot-lua-tikz.sty (Latexにgnuplotのグラフを挿入したい場合は必要)
mkdir -p ~/.TinyTeX/texmf-local/tex/latex/gnuplot
cd  ~/.TinyTeX/texmf-local/tex/latex/gnuplot
gnuplot -e "set term tikz createstyle"
~/.local/bin/mktexlsr
