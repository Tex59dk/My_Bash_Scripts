#!/bin/sh

#theurl="https://ellanet.fr"
#zenity --text-info --width="1200" --height="800" --title="Background Reading" --html --url=$theurl \
       #--checkbox="I read it...and I'm good to go"
#rc=$?
#echo $rc
#case $rc in
    #0)
        #echo "Start some next step"
    ## next step
    #;;
    #1)
        #echo "Stop installation!"
    #;;
   #-1)
        #echo "An unexpected error has occurred."
    #;;
#esac



rc=5
while [ $rc -eq 5 ];
do
  zenity --info --text=$(date +'%S' ) \
  --title="Seconds Timer Test" --timeout=5 --ok-label Quit $ zenity --info \
  --text=$(date +'%S' )   --title="Seconds Timer Test" 2>/dev/null
 
  rc=$? 
  echo $rc
done


( for i in `seq 1 100`; do echo $i; echo "# $i";  sleep 1; done ) | zenity --progress
