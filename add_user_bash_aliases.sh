#!/bin/bash

YELLOW="\033[1;33m"
GREEN="\033[32m"
BLINK="\e[5m"
RED="\033[0;31m"
END="\033[0m"

if [ "$(id -u)" -eq 0" ]; then
    echo -e $RED$BLINK"\nCe script ne nécessite pas d'élévation des autorisations !\n"$END
    echo -e $GREEN"Veuillez exécuter ce script avec  un utilisateur 'non-Root''...\n"$END
    exit 1
fi

FILE=${HOME}/.bash_aliases
EXIST=0
if [ -f "$FILE" ]; then
   echo -e $RED$BLINK"\nAttention !!!\n"$END
   echo -e $YELLOW"Le fichier '$FILE' existe.\n"$END
   echo -e $YELLOW"Voici son contenu :\n"$END
   cat $FILE
   echo -e $GREEN"\nQue souhaitez-vous faire ?\n\n"$END
   EXIST=1
   choix=a
   while [ $choix != "R" ] && [ $choix != "A" ] && [ $choix != "Q" ]
   do
      echo -e "\nLe [R]emplacer, y [A]jouter les nouveaux Alias ou [Q]uitter ? \(R/A/Q\) : "
      read -n 1 choix
      choix=${choix^}
   done
fi

echo -e "\n"

if [ $choix = "Q" ]; then
   echo -e $GREEN"\nAnnulation des opérations...\n"$END
   exit 0
fi

if [ $choix = "R" ]; then
   echo -e $GREEN"\nRemplacement du fichier '.bash_aliases' du dossier '/root/'...\n"$END
   echo "### Alias ajoutés par EllaNet \###" > $FILE
fi

if [ $choix = "A" ]; then
   echo -e $GREEN"\nAjout d\'alias dans le fichier\'.bash_aliases\'...\n"$END
   echo "### Alias ajoutés par EllaNet \###" >> $FILE
fi

if [ $EXIST = 0 ]; then
   echo -e $GREEN"\nCréation du fichier '.bash_aliases' dans le dossier '/root/'...\n"$END
   echo "### Alias ajoutés par EllaNet \###" > $FILE
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

echo -e $GREEN"\nNouvels Alias Root ajoutés. Vous pouvez utiliser :\n"$END
echo -e "  -> 'saptu' à la place de 'sudo apt update && sudo apt-file update'\n"
echo -e "  -> 'sapts' à la place de 'sudo apt search'\n"
echo -e "  -> 'saptf' à la place de 'sudo apt-file search'\n"
echo -e "  -> 'sapti' à la place de 'sudo apt install'\n"
echo -e "  -> 'saptir' à la place de 'sudo apt install --install-recommends'\n"
echo -e "  -> 'saptg' à la place de 'sudo apt upgrade'\n"
echo -e "  -> 'saptfu' à la place de 'sudo apt full-upgrade'\n"
echo -e "  -> 'saptdu' à la place de 'sudo apt dist-upgrade'\n"
echo -e $GREEN"\nDe plus, les commandes suivantes ont été étendues :\n"$END
echo -e "  -> ajout de '-c 4' à la commande 'ping'\n"
echo -e "  -> ajout de '-p' à la commande 'mkdir'\n"



