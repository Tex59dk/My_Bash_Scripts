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

echo -e "Présente :\n"
echo -e "Le script qui installe ce qui manque sur une nouvelle installation."
echo -e "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
echo -e "\n\n"

userco=$USER
usercom=${userco^}

echo -e "Bonjour $usercom,"

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

if [ "$(id -u)" -ne "0" ] ; then
   echo -e "\n\nAttention !\nCe script doit être exécuter en tant qu'utilisateur Root (Administrateur)...\nVeuillez utiliser la commande : sudo $0"
   exit 1
fi

apt update
apt upgrade

# Installation des paquets manquants
PKGS="samba ssh apt-file grsync terminator locate dialog bash-completion needrestart needrestart-session command-not-found packagekit-command-not-found snapd appstream apt-config-icons flatpak"
for paquet in $PKGS
do
   dpkg -l $paquet > /dev/null 2>&1
   INSTALLED=$?
   if [ $INSTALLED == '0' ]; then
      echo -e "\nPaquet \"$paquet\" déjà installé !"
      choix=a
      while [ $choix != "O" ] && [ $choix != "N" ]
      do
         printf "Souhaitez-vous le réinstaller ? (O/N) : "
         read -n 1 choix
         choix=${choix^}
      done
      echo -e "\n"
      if [ $choix = "O" ]; then
         echo -e "Réinstallation du Paquet \"$paquet\" et de ses dépendances !\n"
         apt-get install -y --reinstall $paquet
         if [ $paquet == "apt-file" ]; then
            apt-file update
         fi
         if [ $paquet == "locate" ]; then
            updatedb
         fi
      else
         echo -e "Le Paquet \"$paquet\" ne sera pas réinstallé !\n"
      fi
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
         apt-get install -y $paquet
         if [ $paquet == "apt-file" ]; then
            apt-file update
         fi
         if [ $paquet == "locate" ]; then
            updatedb
         fi
         if [ $paquet == "flatpak" ]; then
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            apt install gnome-software-plugin-flatpak
         fi
      else
         echo -e "Le Paquet \"$paquet\" ne sera pas installé !\n"
      fi
   fi
done

# Add aliases to root
echo "alias apti='apt install'" > /root/.bash_aliases
echo "alias aptu='apt update && apt-file update'" >> /root/.bash_aliases
echo "alias apts='apt search'" >> /root/.bash_aliases
echo "alias aptf='apt-file search'" >> /root/.bash_aliases
echo "alias aptg='apt upgrade'" >> /root/.bash_aliases
echo "alias aptfu='apt full-upgrade'" >> /root/.bash_aliases
echo "alias aptdu='apt dist-upgrade'" >> /root/.bash_aliases
echo "alias ping='ping -c 4'" >> /root/.bash_aliases
echo "alias mkdir='mkdir -p'" >> /root/.bash_aliases

source /root/.bashrc

echo -e "\n\nNouvels Alias Root ajoutés. Vous pouvez utiliser :"
echo -e "  * 'apti' à la place de 'apt install'"
echo -e "  * 'aptu' à la place de 'apt update && apt-file update'"
echo -e "  * 'apts' à la place de 'apt search'"
echo -e "  * 'aptf' à la place de 'apt-file search'"
echo -e "  * 'aptg' à la place de 'apt upgrade'"
echo -e "  * 'aptdu' à la place de 'apt dist-upgrade'"
echo -e "  * 'aptfu' à la place de 'apt full-upgrade'"

# Configure smb.conf
smbtxt="\ \n\ \ \ client min protocol = NT1\n\ \ \ server min protocol = NT1"
sed -i "/usershare allow guests/a ${smbtxt}" /etc/samba/smb.conf

echo -e "\n\n**********************************************************"
echo -e "Opérations terminées.\n"
