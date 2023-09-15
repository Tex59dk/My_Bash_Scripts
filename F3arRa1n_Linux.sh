#!/bin/bash

clear 

echo "[F3ARRA1N] INSTALL"



DESK_path=$(xdg-user-dir DESKTOP)



rm $DESK_path/F3arRa1n.desktop
rm -rf $DESK_path/F3arRa1n/

cd $DESK_path/
mkdir F3arRa1n
cd F3arRa1n

wget "http://f3arra1n.com/Downloads/F3arRa1n_Linux.zip" -O F3arRa1n.zip
unzip F3arRa1n.zip
rm F3arRa1n.zip



chmod -R 777 ./



echo '[Desktop Entry]' >> $DESK_path/F3arRa1n.desktop
echo 'Version=3.0' >> $DESK_path/F3arRa1n.desktop
echo 'Type=Application' >> $DESK_path/F3arRa1n.desktop
echo 'Encoding=UTF-8' >> $DESK_path/F3arRa1n.desktop
echo 'Name=F3arRa1n' >> $DESK_path/F3arRa1n.desktop
echo 'Comment=F3arRa1n' >> $DESK_path/F3arRa1n.desktop
echo "Exec=$DESK_path/F3arRa1n/F3arRa1n-Start.command" >> $DESK_path/F3arRa1n.desktop
echo "Icon=$DESK_path/F3arRa1n/Datos/Icono.png" >> $DESK_path/F3arRa1n.desktop
echo 'Terminal=true' >> $DESK_path/F3arRa1n.desktop

chmod 777 $DESK_path/F3arRa1n.desktop

clear 

echo "---------------------------"
echo "[F3ARRA1N] INSTALL OK!"
echo "---------------------------"
echo "READ READ READ READ"
echo "---------------------------"
echo "Double click the F3arRa1n icon on your desktop to open the tool."
echo "If the icon does not appear on the desktop or doesn't work, go inside the F3arRa1n folder and drag the Start.command file to a Terminal and press Return."
echo "---------------------------"
echo "LEE LEE LEE LEE"
echo "---------------------------"
echo "Haga doble clic en el icono F3arRa1n de su escritorio para abrir la herramienta"
echo "Si el icono no aparece en el escritorio o no funciona, ve dentro de la carpeta F3arRa1n y arrastra el archivo Start.command a una Terminal y presiona Enter."
echo "---------------------------"