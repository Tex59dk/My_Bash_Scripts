#!/usr/bin/bash
#Définition des couleurs
fbinit="\E[0m"
fred="\E[31m"
fgreen="\E[32m"
fyellow="\E[33m"
if [ "$1" == "" ]; then
    echo -e "\n${fred}Erreur ! ${fyellow}Fichier à convertir non spécifié.${fbinit}"
    echo -e "Utilisation : $0 ${fgreen}monfichier"
    echo -e "    monfichier${fbinit} : fichier .txt sans son extension\n"
    exit 1
else
    nom=$1

    if [ ${nom#*.} == ${nom%%.*} ]; then

        echo -e "\nConversion de '$nom.txt' en '$nom.ino' dans le dossier '$nom'\n"
        if [ -f $nom.txt ]; then
            python2 DuckyEncoder/duckencoder.py -i $nom.txt -o $nom.bin -l fr
            err=$?
            if [ $err -ne 0 ]; then
                echo -e "\n${fred}Il y a eu des erreurs.${fyellow} Veuillez vérifier votre fichier '$nom.txt'.\n${fbinit}"
                exit $err
            fi
            mkdir \$nom
            python2 duck2spark/duck2spark.py -i $nom.bin -l 1 -f 2000 -o $nom\$nom.ino
            if [ $err -eq 0 ]; then
                echo -e "\n${fgreen}Conversion terminée avec succès.${fbinit}"
                echo -e "Le fichier '$nom.ino' se trouve dans le dossier '$nom'.\n"
            else
                echo -e "\n${fred}Il y a eu des erreurs.${fbinit}"
                echo -e "Le fichier '$nom.txt' n'a pas pu être converti.\n"
                exit $err
            fi
        else
            echo -e "\n${fred}Erreur ! ${fyellow}Le fichier '$nom.txt' est introuvable.\n${fbinit}"
            exit 1
        fi
    else
        echo -e "\n${fred}Erreur ! ${fyellow}Le fichier '$nom' ne doit pas contenir d'extension.\n${fbinit}"
        exit 1
    fi
fi
