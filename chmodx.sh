#!/bin/sh

erreur () {
    echo ""
    echo "Utilisation : $0 {Option} \"Filtre\" Autorisations"
    echo "Option :"
    echo "   f : Change récursivement les autorisations de fichiers"
    echo "   d : Change récursivement les autorisations de dossiers"
    echo ""
    echo "Exemples :"
    echo "   $0 d \"*\" 755 : Change récursivement les autorisations de tous les dossiers en 755"
    echo "   $0 f \"*.sh\" +x : Rend récursirvement exécutables les fichiers finissant par .sh"
    echo ""
    exit 1
}

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "\n$0 par Tex59dk - Aide :"
    erreur
fi

if [ "$1" != "f" ] && [ "$1" != "d" ]; then
    echo "\nErreur !"
    echo "f ou d requis !"
    erreur
fi

if [ "$2" = "" ]; then
    echo "\nErreur !"
    echo "Filtre requis !"
    erreur
fi

if [ "$3" = "" ]; then
    echo "\nErreur !"
    echo "Autorisations requises !"
    erreur
fi

find . -type $1 -name "$2" -exec chmod $3 {} \;
# find . -type $1 -name "$2" -print

