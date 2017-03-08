#!/bin/bash
mkdir -p /tmp/adodefont
cd /tmp/adodefont
if [ ! -f "1.030R-it.zip" ]
then
  wget https://github.com/adobe-fonts/source-code-pro/archive/2.010R-ro/1.030R-it.zip
  unzip 1.030R-it.zip
  mkdir -p ~/.fonts
  cp source-code-pro-2.010R-ro-1.030R-it/OTF/*.otf ~/.fonts/
  fc-cache -f -v
fi
