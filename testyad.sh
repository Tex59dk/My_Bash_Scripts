#!/bin/sh
names=$(echo "Waters,Gilmour,Wright,Mason")
occupation=$(echo "Basse,Guitare,Claviers,Drums")
yad --form --separator="," --item-separator="," --field="qui:CB" --field="quoi:CBE" --field="blabla:TXT" \
"$names" "$occupation" "Type your comments here" | while read LL ; do
   echo "NAME='`echo $LL | awk -F',' '{print $1}'`'" > /tmp/config
   echo "OCCUPATION='`echo $LL | awk -F',' '{print $2}'`'" >> /tmp/config
   echo "COMMENT='`echo $LL | awk -F',' '{print $3}'`'" >> /tmp/config
done
