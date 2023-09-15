#! /bin/bash
while IFS="," read -r nom prenom numtel ident apikey
do
  echo "Affichage des informations de : $prenom $nom"
  echo "Numéto de téléphone : $numtel"
  echo "Identifiant : $ident"
  echo "Clé API : $apikey"
  echo ""
  echo "--------------------------------------------"
  echo ""
done < <(tail -n +2 API-SMS-Free.csv)


NOM_FICHIER_CSV="API-SMS-Free.csv"

nom=( $(tail -n +2 ${NOM_FICHIER_CSV} | cut -d ',' -f1) )
prenom=( $(tail -n +2 ${NOM_FICHIER_CSV} | cut -d ',' -f2) )
numtel=( $(tail -n +2 ${NOM_FICHIER_CSV} | cut -d ',' -f3) )
ident=( $(tail -n +2 ${NOM_FICHIER_CSV} | cut -d ',' -f4) )
apikey=( $(tail -n +2 ${NOM_FICHIER_CSV} | cut -d ',' -f5) )
echo ""
echo "############################################"
echo "############################################"
echo ""
echo "Liste des Noms  : ${nom[@]}"
echo ""
echo "Liste des Prénoms   : ${prenom[@]}"
echo ""
echo "Liste des Numéros de Téléphone : ${numtel[@]}"
echo ""
echo "Liste des Identifiants : ${ident[@]}"
echo ""
echo "Liste des Clés API : ${apikey[@]}"
echo ""
echo ""
echo "############################################"
echo "############################################"
echo ""
echo "Nombre d'enregistrements : ${#nom[@]}"
echo "Nombre d'enregistrements : ${#nom[*]}"
echo ""
echo "############################################"
echo "############################################"
echo ""

nbrereg=${#nom[@]}

for (( c=0; c<nbrereg; c++ ))
do
  echo "Affichage des informations de : ${prenom[$c]} ${nom[$c]}"
  echo "Numéto de téléphone : ${numtel[$c]}"
  echo "Identifiant : ${ident[$c]}"
  echo "Clé API : ${apikey[$c]}"
  echo ""
  echo "--------------------------------------------"
  echo ""
done

