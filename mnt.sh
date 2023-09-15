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
echo "Présente :"
echo ""
echo "Le script qui permet de monter ou démonter un lecteur"
echo "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
echo ""

if [ "$(id -u)" -ne "0" ]; then
   dpkg -l zenity > /dev/null 2>&1
   INSTALLED=$?
   if [ $INSTALLED == '0' ]; then
      zenity --error --title "Attention !!!" --width 500 --height 100 --text "Ce script doit être exécuter en tant qu'utilisateur Root (Administrateur)...\nVous pouvez utiliser la commande : sudo $0"
   else
      echo -e "Attention !!!\nCe script doit être exécuter en tant qu'utilisateur Root (Administrateur)...\nVous pouvez utiliser la commande : sudo $0"
   fi
   exit 1
fi

# Specify the mount point
if [ "$1" == "" ]; then
    # List available partitions
    lsblk
    echo ""
    read -p "Veuillez indiquer le chemin du dossier sur lequel effectuer le (dé)montage (par défaut : /mnt/temp) : " mount_point
    if [ "$mount_point" == "" ]; then
        mount_point="/mnt/temp"
    fi
else
    mount_point="$1"
fi

# Check if the mount point already used
if grep -qs "$mount_point" /proc/mounts; then
    echo -e "\nUn lecteur est déjà monté ici : $mount_point"
    choix=a
    while [ "$choix" != "O" ] && [ "$choix" != "N" ]
    do
       printf "\nSouhaitez-vous démonter le lecteur ? (O/N) : "
       read -n 1 choix
       choix=${choix^}
       #echo -e "\n\nChoix : $choix\n\n"
    done
    if [ "$choix" = "N" ]; then
       echo -e "\nOK... Arrêt du script.\n"
       exit 0
    fi
    echo -e "\nOK... Démontage du lecteur..."
    umount "$mount_point"
    succes=$?
    if [ $succes == '0' ]; then
        echo -e "\nLecteur démonté avec succès."
    else
        echo -e "\nErreur lors du démontage du lecteur.\nArrêt du script."
        exit $succes
    fi

    choix=a
    while [ "$choix" != "O" ] && [ "$choix" != "N" ]
    do
       printf "\nSouhaitez-vous supprimer le dossier '$mount_point' ? (O/N) : "
       read -n 1 choix
       choix=${choix^}
       #echo -e "\n\nChoix : $choix\n\n"
    done
    if [ "$choix" = "N" ]; then
       echo -e "\nOK... Arrêt du script.\n"
       exit 0
    fi
    echo -e "\nOK... Suppression du dossier..."
    rm -r $mount_point
    succes=$?
    if [ $succes == '0' ]; then
        echo -e "\nDossier supprimé avec succès."
    else
        echo -e "\nErreur lors de la suppression du dossier.\nArrêt du script."
        exit $succes
    fi
else
    if [ -d "$mount_point" ]; then
        if [ -z "$(find "$mount_point" -mindepth 1)" ]; then
            echo -e "\nLe dossier '$mount_point' existe déjà et est vide."
        else
            echo -e "\nLe dossier '$mount_point' existe déjà et n'est pas vide."
            echo -e "\nATTENTION !!!\nSi vous souhaitez continuer, le contenu du dossier sera perdu !"
        fi
        choix=a
        while [ "$choix" != "O" ] && [ "$choix" != "N" ]
        do
           printf "\nSouhaitez-vous malgré tout utiliser ce dossier ? (O/N) : "
           read -n 1 choix
           choix=${choix^}
           #echo -e "\n\nChoix : $choix\n\n"
        done
        if [ "$choix" = "N" ]; then
           echo -e "\nOK... Arrêt du script.\n"
           exit 0
        fi
        echo -e "\n"
        rm -rf $mount_point
        mkdir -p $mount_point
    else
        echo -e "\nLe dossier '$mount_point' n'existe pas."
        echo -e "Création du dossier."
        mkdir -p $mount_point
        succes=$?
        if [ $succes == '0' ]; then
            echo -e "\nDossier '$mount_point' créé avec succès.\n\n"
        else
            echo -e "\nErreur lors de la création du dossier '$mount_point'.\nArrêt du script."
            exit $succes
        fi
    fi

    # List available partitions
    lsblk

    # Prompt for partition selection
    echo ""
    read -p "Veuillez indiquer le chemin de la partition que vous souhaitez monter (par ex : sdb1): " device_path
    device_path="/dev/$device_path"
    # Check if the device path exists
    if [ -b "$device_path" ]; then
        echo -e "\nMontage du lecteur..."
        mount "$device_path" "$mount_point"
        succes=$?
        if [ $succes == '0' ]; then
            echo -e "\nLecteur '$device_path' monté avec succès dans le dossier '$mount_point'."
        else
            echo -e "\nErreur lors du montage du lecteur '$device_path' dans le dossier '$mount_point'.\nArrêt du script."
            exit $succes
        fi
    else
        echo -e "\nPas de lecteur sur le chemin '$device_path'. Veuillez vérifier."
        exit 1
    fi
fi
