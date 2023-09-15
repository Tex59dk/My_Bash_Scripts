#!/bin/bash

YELLOW="\033[1;33m"
GREEN="\033[32m"
BLINK="\e[5m"
RED="\033[0;31m"
END="\033[0m"

if [ "$(id -u)" -eq 0" ]; then
    printf $RED$BLINK"\nCe script ne nécessite pas d'élévation des autorisations !\n"$END
    printf $GREEN"Veuillez exécuter ce script avec  un utilisateur 'non-Root''...\n"$END
    exit 1
fi

FILE=${HOME}/.bash_aliases
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
   echo "### Alias ajoutés par EllaNet ###" > $FILE
fi

if [ $choix = "A" ]; then
   printf $GREEN"\nAjout d'alias dans le fichier '.bash_aliases'...\n"$END
   echo "\n### Alias ajoutés par EllaNet ###" >> $FILE
fi

if [ $EXIST = 0 ]; then
   printf $GREEN"\nCréation du fichier '.bash_aliases' dans le dossier '/root/'...\n"$END
   echo "### Alias ajoutés par EllaNet ###" > $FILE
fi

echo "alias saptu=\"sudo apt update && sudo apt-file update\"" >> $FILE
echo "alias sapts=\"sudo apt search\"" >> $FILE
echo "alias saptf=\"sudo apt-file search\"" >> $FILE
echo "alias sapti=\"sudo apt install\"" >> $FILE
echo "alias saptir=\"sudo apt install --install-recommends\"" >> $FILE
echo "alias saptg=\"sudo apt upgrade\"" >> $FILE
echo "alias saptfu=\"sudo apt full-upgrade\"" >> $FILE
echo "alias saptdu=\"sudo apt dist-upgrade\"" >> $FILE
echo "alias ping=\"ping -c 4\"" >> $FILE
echo "alias mkdir=\"mkdir -p\"" >> $FILE
source /root/.bashrc

printf $GREEN"\nNouvels Alias Root ajoutés. Vous pouvez utiliser :\n"$END
printf "  -> 'saptu' à la place de 'sudo apt update && sudo apt-file update'\n"
printf "  -> 'sapts' à la place de 'sudo apt search'\n"
printf "  -> 'saptf' à la place de 'sudo apt-file search'\n"
printf "  -> 'sapti' à la place de 'sudo apt install'\n"
printf "  -> 'saptir' à la place de 'sudo apt install --install-recommends'\n"
printf "  -> 'saptg' à la place de 'sudo apt upgrade'\n"
printf "  -> 'saptfu' à la place de 'sudo apt full-upgrade'\n"
printf "  -> 'saptdu' à la place de 'sudo apt dist-upgrade'\n"
printf $GREEN"\nDe plus, les commandes suivantes ont été étendues :\n"$END
printf "  -> ajout de '-c 4' à la commande 'ping'\n"
printf "  -> ajout de '-p' à la commande 'mkdir'\n"

printf "\n"

#EOF

