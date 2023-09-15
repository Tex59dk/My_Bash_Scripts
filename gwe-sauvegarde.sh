#!/bin/bash

clear
printf "\n"
printf " _____  _  _       \033[7m _   _       _   \033[m\n"
printf "| ____|| || | __ _ \033[7m| \\ | | ___ | |_ \033[m\n"
printf "|  _|  | || |/ _\` |\033[7m|  \\| |/ _ \\| __|\033[m\n"
printf "| |___ | || | (_| |\033[7m| |\\  |  __/| |_ \033[m\n"
printf "|_____||_||_|\\__,_|\033[7m|_| \\_|\\___| \\__|\033[m\n"
printf "                   \033[7m                 \033[m\n"
printf "\n\nPrésente :\n\n"
printf "Le script qui permet de recréer le lien Sauvegarde de NextCloud sur le VPS EllaNet.\n"
printf "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*\n"
printf "\n\n"

if [ ! -L "/home/yunohost.app/nextcloud/data/gwe/files/Sauvegarde" ]; then
    printf "Le lien symbolique Sauvegarde de NextCloud n'existe plus.\n"
    printf "Recréation du Lien.\n"
    #~ ln -s /home/gwe/Sauvegarde /home/yunohost.app/nextcloud/data/gwe/files/Sauvegarde
fi
