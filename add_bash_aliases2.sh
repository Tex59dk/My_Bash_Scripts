#!/bin/bash

YELLOW="\033[1;33m"
GREEN="\033[32m"
BLINK="\e[5m"
RED="\033[0;31m"
END="\033[0m"

if [ "$(id -u)" -ne "0" ]; then
    printf $RED$BLINK"\nCe script nécessite une élévation des autorisations !\n"$END
    printf $GREEN"Veuillez utiliser 'sudo' ou exécuter ce script avec l'utilisateur 'Root'...\n"$END
    exit 1
fi

FILE=/root/.bash_aliases
EXIST=0
if [ -f "$FILE" ]; then
   printf $RED$BLINK"\nAttention !!!\n"$END
   printf $YELLOW"Le fichier '$FILE' existe.\n"$END
   printf $YELLOW"Voici son contenu :\n"$END
   cat $FILE
   printf $GREEN"\nQue souhaitez-vous faire ?\n\n"$END
   EXIST=1
   choix=a
   while [ $choix != "R" ] && [ $choix != "A" ] && [ $choix != "Q" ]
   do
      printf "\rLe [R]emplacer, y [A]jouter les nouveaux Alias ou [Q]uitter ? (R/A/Q) : "
      read -n 1 choix
      choix=${choix^}
   done
fi

printf "\n"

if [ $choix = "Q" ]; then
   printf $GREEN"\nAnnulation des opérations...\n"$END
   exit 0
fi

if [ $choix = "R" ]; then
   printf $GREEN"\nRemplacement du fichier '.bash_aliases' du dossier '/root/'...\n"$END
   echo "### Alias ajoutés par EllaNet ###" > /root/.bash_aliases
fi

if [ $choix = "A" ]; then
   printf $GREEN"\nAjout d'alias dans le fichier '.bash_aliases'...\n"$END
   echo "\n### Alias ajoutés par EllaNet ###" >> /root/.bash_aliases
fi

if [ $EXIST = 0 ]; then
   printf $GREEN"\nCréation du fichier '.bash_aliases' dans le dossier '/root/'...\n"$END
   echo "### Alias ajoutés par EllaNet ###" > /root/.bash_aliases
fi

echo "alias aptu=\"apt update && apt-file update\"" >> /root/.bash_aliases
echo "alias apts=\"apt search\"" >> /root/.bash_aliases
echo "alias aptf=\"apt-file search\"" >> /root/.bash_aliases
echo "alias apti=\"apt install\"" >> /root/.bash_aliases
echo "alias aptg=\"apt upgrade\"" >> /root/.bash_aliases
echo "alias aptfu=\"apt full-upgrade\"" >> /root/.bash_aliases
echo "alias aptdu=\"apt dist-upgrade\"" >> /root/.bash_aliases
echo "alias ping=\"ping -c 4\"" >> /root/.bash_aliases
echo "alias mkdir=\"mkdir -p\"" >> /root/.bash_aliases
source /root/.bashrc

printf $GREEN"\nNouvels Alias Root ajoutés. Vous pouvez utiliser :\n"$END
printf "  -> 'aptu' à la place de 'apt update && apt-file update'\n"
printf "  -> 'apts' à la place de 'apt search'\n"
printf "  -> 'aptf' à la place de 'apt-file search'\n"
printf "  -> 'apti' à la place de 'apt install'\n"
printf "  -> 'aptg' à la place de 'apt upgrade'\n"
printf "  -> 'aptfu' à la place de 'apt full-upgrade'\n"
printf "  -> 'aptdu' à la place de 'apt dist-upgrade'\n"
printf $GREEN"\nDe plus, les commandes suivantes ont été étendues :\n"$END
printf "  -> ajout de '-c 4' à la commande 'ping'\n"
printf "  -> ajout de '-p' à la commande 'mkdir'\n"

printf "\n"

#EOF
