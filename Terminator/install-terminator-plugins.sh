#!/bin/bash

clear
echo -e "\n"
echo -e " _____  _  _       \033[7m _   _       _   \033[m"
echo -e "| ____|| || | __ _ \033[7m| \\ | | ___ | |_ \033[m"
echo -e "|  _|  | || |/ _\` |\033[7m|  \\| |/ _ \\| __|\033[m"
echo -e "| |___ | || | (_| |\033[7m| |\\  |  __/| |_ \033[m"
echo -e "|_____||_||_|\\__,_|\033[7m|_| \\_|\\___| \\__|\033[m"
echo -e "                   \033[7m                 \033[m"
echo -e "\n"
echo -e "\nPrésente :\n"
echo -e "Le script qui installe des plugins pour Terminator."
echo -e "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
echo -e "\n"

userco=$USER
usercom=${userco^}

echo -e "Bonjour $usercom,"

file=$( find ~/.thunderbird/ -iname "prefs.js" -print )
echo -e "\nFichier 'prefs.js' trouvé ici : $file"

choix=a
while [ $choix != "O" ] && [ $choix != "N" ]
do
printf "\nSouhaitez-vous continuer ? (O/N) : "
read -n 1 choix
choix=${choix^}
done

echo -e "\n"

if [ $choix = "N" ]; then
echo -e "Arrêt du script.\n"
exit 0
fi

wasactif=0
while [ "$(pidof terminator)" != "" ]
do
printf "L'application 'Terminator' est active.\nVeuillez la fermer et appuyer sur la touche (Entrèe).\n"
read -n 1 choix
wasactif=1
done

oldvar='("mailnews.default_news_sort_order", 1)'
newvar='("mailnews.default_news_sort_order", 2)'
sed -i "s/$oldvar/$newvar/" $file
oldvar='("mailnews.default_sort_order", 1)'
newvar='("mailnews.default_sort_order", 2)'
sed -i "s/$oldvar/$newvar/" $file

echo -e "Fichier 'prefs.js' mis à jour."
if [ $wasactif -eq 1 ]
then
echo -e "Vous pouvez redémarrer Thunderbird.\n"
else
echo -e "Vous pouvez démarrer Thunderbird.\n"
fi

