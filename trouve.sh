#!/bin/bash

if [ "$1" == "" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    echo "Utilisation :"
    echo "   $0 TYPE PATTERN [Action]"
    echo "   TYPE : d (dossier) ou f (fichier)"
    echo "   PATTERN : Recherche à effectuer"
    echo "   Action : Vide = Liste les fichiers ou dossiers correspondants à PATTERN"
    echo "            del = suppression"
    echo "            delvide = suppression des fichiers ou dossiers vides"
    echo "            Sinon, action à exécuter pour chaque fichier ou dossier trouvé"
    exit 0
fi

if [ "$1" != "f" ] && [ "$1" != "d" ]; then
    echo "Utilisation :"
    echo "   $0 TYPE PATTERN [Action]"
    echo "   TYPE : d (dossier) ou f (fichier)"
    echo "   PATTERN : Recherche à effectuer"
    echo "   Action : si rien d'indiqué, Liste les fichiers ou dossiers correspondants à PATTERN"
    echo "            del = suppression des fichiers ou dossiers correspondants à PATTERN"
    echo "            vide = Liste les fichiers ou dossiers vides correspondants à PATTERN"
    echo "            delvide = suppression des fichiers ou dossiers vides correspondants à PATTERN"
    echo "            Sinon, action à exécuter pour chaque fichier ou dossier trouvé"
    exit 1
fi

if [ "$3" == "" ]; then
    find . -type $1 -iname "$2"
    exit 0
fi

if [ "$3" == "del" ]; then
    find . -type $1 -iname "$2" -delete
    exit 0
fi

if [ "$3" == "vide" ]; then
    find . -type $1 -iname "$2" -empty
    exit 0
fi

if [ "$3" == "delvide" ]; then
    find . -type $1 -iname "$2" -empty -delete
    exit 0
fi

#~ if [ "$3" == "" ]; then
    #~ find . -type $1 -iname "$2"
    #~ exit
#~ fi

find . -type $1 -iname "$2" -exec $3 {} ;
