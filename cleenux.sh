#!/bin/bash
clear

YELLOW="\033[1;33m" GREEN="\033[32m" BLINK="\e[5m" REDL="\e[101m" RED="\033[0;31m" END="\033[0m"

OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
CURKERNEL=$(uname -r|sed 's/-*[a-z]//g'|sed 's/-386//g')
LINUXPKG="linux-(image|headers|debian-modules|restricted-modules)"
METALINUXPKG="linux-(image|headers|restricted-modules)-(generic|i386|server|common|rt|xen)"
OLDKERNELS=$(dpkg -l|awk '{print $2}'|grep -E $LINUXPKG |grep -vE $METALINUXPKG|grep -v $CURKERNEL)

printf $GREEN"************************************************************************\n"$END
printf $GREEN"************************** CLEENUX FOR DEBIAN **************************\n"$END
printf $GREEN"************************      GITHUB/KID-X      ************************\n"$END
printf $GREEN"************************************************************************\n"$END
printf "\n"

sleep 1
                                                                                                                                                                                                                                         
# ======================================================================================

printf $YELLOW"CLEENUX >> FIXING BROKEN INSTALLATIONS...\n"$RED
sudo apt --fix-broken install
printf $GREEN"DONE!\n"$RED
printf "\n"

# ======================================================================================

printf $YELLOW"CLEENUX >> CLEARING RETRIEVED PACKAGE FILES...\n"$RED
sudo apt autoclean
printf $GREEN"DONE!\n"$RED
printf "\n"

# ======================================================================================

printf $YELLOW"CLEENUX >> CLEARING DEPENDENCIES THAT ARE NO LONGER REQUIRED...\n"$RED
sudo apt autoremove
printf $GREEN"DONE!\n"$RED
printf "\n"

# ======================================================================================

printf $YELLOW"CLEENUX >> CLEARING OLD CONFIG FILES...\n"$RED
sudo apt purge $OLDCONF
printf $GREEN"DONE!\n"$RED
printf "\n"

# ======================================================================================

printf $YELLOW
printf $BLINK
read -p "WARNING! DOUBLE CHECK THE TRASH FOR ITEMS YOU WANT & [ENTER]"
printf $END
printf $YELLOW"CLEENUX >> CLEARING TRASHED ITEMS...\n"$RED
rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
rm -rf /root/.local/share/Trash/*/** &> /dev/null
printf $GREEN"DONE!\n"$RED
printf "\n"

# ======================================================================================

# ACTIVATE THIS STEP BY REMOVING HASH SIGNS TO REMOVE ALL OLD KERNELS [AT YOUR OWN RISK]
# --------------------------------------------------------------------------------------
printf $YELLOW"CLEENUX >> CLEARING OLD KERNELS...\n"$REDL
printf $BLINK"WARNING! REMOVING KERNALS COULD CAUSE PROBLEMS. CONTINUE? [Y/N] : "$RED
printf "\n" 
sudo apt purge $OLDKERNELS
printf $GREEN"DONE!\n"$RED
printf "\n"
# --------------------------------------------------------------------------------------

# ======================================================================================

printf $GREEN"CLEENUX >> REMOVED ALL UNWANTED FILES, TRASHES AND TEMP FILES.\n"$END
printf "\n"

exit
