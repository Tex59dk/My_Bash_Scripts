#!/bin/bash

clear
echo -e "\n"
echo -e " _____  _  _       \033[7m _   _       _   \033[m"
echo -e "| ____|| || | __ _ \033[7m| \\ | | ___ | |_ \033[m"
echo -e "|  _|  | || |/ _\` |\033[7m|  \\| |/ _ \\| __|\033[m"
echo -e "| |___ | || | (_| |\033[7m| |\\  |  __/| |_ \033[m"
echo -e "|_____||_||_|\\__,_|\033[7m|_| \\_|\\___| \\__|\033[m"
echo -e "                   \033[7m                 \033[m"
echo -e "\n\nPrésente :\n"
echo -e "Le script qui permet de convertir des FLAC en MP3"
echo -e "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*\n"
userco=$USER
usercom=${userco^}
echo -e "Bonjour $usercom,"

ls -A1 $1/*.flac

if ls $1/*.flac > /dev/null 2>&1 ; then
   nbflac=$(ls -A1 $1/*.flac | wc -l)
   echo -e "\nIl y a $nbflac fichiers 'flac' dans le dossier actuel."
else
   echo -e "\nAucun fichier 'flac' dans le dossier actuel !\n";
   exit 2
fi

choix=a
while [ $choix != "O" ] && [ $choix != "N" ]
do
   printf "\nSouhaitez-vous continuer ? (O/N) : "
   read -n 1 choix
   choix=${choix^}
   #echo -e "\n\nChoix : $choix\n\n"
done

echo -e "\n"

if [ $choix = "N" ]; then
   echo -e "Arrêt du script.\n"
   exit 0
fi

# Installation des paquets manquants
PKGS="ffmpeg"
for paquet in $PKGS
do
   dpkg -l $paquet > /dev/null 2>&1
   INSTALLED=$?
   if [ $INSTALLED == '0' ]; then
      echo -e "\nPaquet \"$paquet\" présent !"
   else
      echo -e "\nPaquet \"$paquet\" non installé !"
      choix=a
      while [ $choix != "O" ] && [ $choix != "N" ]
      do
         printf "Souhaitez-vous l'installer ? (O/N) : "
         read -n 1 choix
         choix=${choix^}
      done
      echo -e "\n"
      if [ $choix = "O" ]; then
         echo -e "Installation du Paquet \"$paquet\" et de ses dépendances !\n"
         sucmd=""
         if [ "$(id -u)" -ne "0" ]; then
             echo "\n\nAttention !\nIl se peut que rien n'apparaisse à l'écran quand un mot de passe est saisi...\n"
             sucmd="sudo"
         fi
         $sucmd apt-get install -y $paquet
      else
         echo -e "Le Paquet \"$paquet\" ne sera pas installé !\n  Fin\n"
         exit 0
      fi
   fi
done

if [ ! -d "mp3" ]; then
   echo -e "\nCréation du dossier 'mp3' dans : $1 !";
   mkdir -p $1/mp3
fi

#find $1/ -iname '*.flac' -exec bash -c 'D=$(dirname "{}"); B=$(basename "{}"); mkdir "$D/mp3"; ffmpeg -i "{}" -ab 128k -map_metadata 0 -id3v2_version 3 -acodec libmp3lame "$D/mp3/${B%.*}.mp3"' \;
find $1/ -iname '*.flac' -exec bash -c 'D=$(dirname "{}"); B=$(basename "{}"); mkdir "$D/mp3"; ffmpeg -i "{}" -ab 128k -map_metadata 0 -id3v2_version 3 -acodec libmp3lame -vsync 2 "$D/mp3/${B%.*}.mp3"' \;

#for FILE in $1/*.flac;
#do
    #ffmpeg -i "$FILE" -ab 320k -map_metadata 0 -id3v2_version 3 "mp3/${FILE%.*}.mp3";
#done
