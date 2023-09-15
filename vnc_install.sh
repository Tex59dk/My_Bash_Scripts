#!/bin/sh

if [ "$(id -u)" -ne "0" ] ; then
   echo -e "\n\nAttention !!!\nCe script doit être exécuter en tant qu'utilisateur Root (Administrateur)...\nVous pouvez utiliser la commande : sudo $0"
   exit 1
fi

ln /usr/lib/aarch64-linux-gnu/libvcos.so /usr/lib/libvcos.so.0
ln /usr/lib/aarch64-linux-gnu/libvchiq_arm.so /usr/lib/libvchiq_arm.so.0
ln /usr/lib/aarch64-linux-gnu/libbcm_host.so /usr/lib/libbcm_host.so.0
ln /usr/lib/aarch64-linux-gnu/libmmal.so /usr/lib/libmmal.so.0
ln /usr/lib/aarch64-linux-gnu/libmmal_core.so /usr/lib/libmmal_core.so.0
ln /usr/lib/aarch64-linux-gnu/libmmal_components.so /usr/lib/libmmal_components.so.0
ln /usr/lib/aarch64-linux-gnu/libmmal_util.so /usr/lib/libmmal_util.so.0
ln /usr/lib/aarch64-linux-gnu/libmmal_vc_client.so /usr/lib/libmmal_vc_client.so.0
ln /usr/lib/aarch64-linux-gnu/libvcsm.so /usr/lib/libvcsm.so.0
ln /usr/lib/aarch64-linux-gnu/libcontainers.so /usr/lib/libcontainers.so.0

systemctl enable vncserver-virtuald.service
systemctl enable vncserver-x11-serviced.service
systemctl start vncserver-virtuald.service
systemctl start vncserver-x11-serviced.service

apt-get install lightdm

