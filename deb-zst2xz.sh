#!/bin/sh
clear
echo " _____  _  _        _   _       _"
echo "| ____|| || | __ _ | \\ | | ___ | |_"
echo "|  _|  | || |/ _\` ||  \\| |/ _ \\| __|"
echo "| |___ | || | (_| || |\\  |  __/| |_"
echo "|_____||_||_|\\__,_||_| \\_|\\___| \\__|"
echo ""
echo "Présente :"
echo ""
echo "Le script qui permet de corriger les erreurs zst."
echo "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
echo ""

## 1er argument (optionnel) : nom du paquet à télécharger puis à convertir ou nom du fichier .deb à convertir

apt-get download $1
if $1 contient .deb ; then
   fdeb = $1
else
   fdeb = $( ls *.deb ) ## fdeb = nom du fichier deb
fi

ar x $fdeb

zstd -d < control.tar.zst | xz > control.tar.xz
zstd -d < data.tar.zst | xz > data.tar.xz

rm *.zst

ndeb = $fdeb + repack

ar rcs $ndeb debian-binary control.tar.xz data.tar.xz

echo "Fichier '$fdeb' converti en '$ndeb'"
