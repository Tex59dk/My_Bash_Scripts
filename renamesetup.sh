#!/bin/bash

#  unzipindir.sh
#
#  Copyright 2023 Tex de Dunkerque <tex59dk@tex59dk.fr>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#
#


clear
echo -e "\n"
echo -e " _____  _  _       \033[7m _   _       _   \033[m"
echo -e "| ____|| || | __ _ \033[7m| \\ | | ___ | |_ \033[m"
echo -e "|  _|  | || |/ _\` |\033[7m|  \\| |/ _ \\| __|\033[m"
echo -e "| |___ | || | (_| |\033[7m| |\\  |  __/| |_ \033[m"
echo -e "|_____||_||_|\\__,_|\033[7m|_| \\_|\\___| \\__|\033[m"
echo -e "                   \033[7m                 \033[m"
echo -e "\n\nTex de Dunkerque présente :\n"
echo -e "Le script qui permet de ."
echo -e "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
echo -e "\n"

usage () {
    echo -e "\nUtilisation : $0 xxxxxxx"
    echo -e "\n"
}

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo -e "\n$0 par Tex de Dunkerque - Aide :"
    usage
    exit 0
fi

#~ if [ "$1" = "" ]; then
    #~ echo "\nErreur !"
    #~ echo "xxx Description xxx!"
    #~ usage
    #~ exit 1
#~ fi

#~ sucmd=""
#~ if [ "$(id -u)" -ne "0" ]; then
    #~ echo "\n\nAttention !\nIl se peut que rien n'apparaisse à l'écran quand un mot de passe est saisi...\n"
    #~ sucmd="sudo"
#~ fi

for fichier in wwb*/*setup.exe; do
    echo "Fichier = $fichier"
    mv $fichier .
    #~ nvfichier="$dossier/${dossier}_setup.exe"
    #~ echo "Nouveau Fichier = $nvfichier"
    #~ if [ -e $fichier ]; then
        #~ echo -e "\n    Le fichier '$fichier' peut être renommer en '$nvfichier'."
        #~ mv $fichier $nvfichier
    #~ fi
    echo -e "\n"
done
