#!/bin/bash

function linux_depends(){

	echo "[F3ARRA1N FOR LINUX]"
	echo "------------------------------"
	echo "[DEPENDENCIES INSTALL NEED YOUR PC PASSWORD FOR SUDO PERMISSIONS]"
	echo "------------------------------"
	echo "[LAS DEPENDENCIAS NECESITAN EL PASSWORD DE LA PC PARA PERMISOS DE SUDO]"
	echo "------------------------------"

	if [[ $(which apt-get) ]]; then
		sudo apt-get install -y git build-essential make autoconf \
		automake libtool openssl tar perl binutils gcc g++ \
		libc6-dev libssl-dev libusb-1.0-0-dev \
		libcurl4-gnutls-dev fuse libxml2-dev \
		libgcc1 libreadline-dev libglib2.0-dev libzip-dev \
		libclutter-1.0-dev  \
		libfuse-dev cython python2.7 python3 python3.7 \
		libncurses5
	else
		echo "WARNING: PLEASE USE A DISTRO USING APT-GET SUCH AS UBUNTU"
		exit 1
	fi
}

function macos_depends(){

	echo "[F3ARRA1N FOR MACOS]"
	echo "------------------------------"
	echo "[DEPENDENCIES INSTALL NEED YOUR MAC PASSWORD FOR SUDO PERMISSIONS]"
	echo "DON'T FORGET TO INSTALL XCODE!!"
	echo "------------------------------"
	echo "[LAS DEPENDENCIAS NECESITAN EL PASSWORD DE LA MAC PARA PERMISOS DE SUDO]"
	echo "NO TE OLVIDES DE INSTALAR XCODE!!"
	echo "------------------------------"

	# Ask for the administrator password upfront.
	sudo -v
	# sleep 10

	# Keep-alive: update existing `sudo` time stamp until the script has finished.
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

	# /bin/bash -c "$(curl -fsSL https://f3arra1n.com/Scripts/Dependencies/uninstall.sh)"

	# Install Hombrew.
	if [[ ! -e $(which brew) ]]; then
		sudo xcode-select --install
		sudo xcode-select --reset
		echo "[BREW] INSTALL"
		echo "------------------------------"
		echo "[PRESS ENTER/RETURN WHEN THE SCRIPTS ASKS FOR IT]"
		echo "------------------------------"
		echo "[PRESIONA ENTER CUANDO EL SCRIPT PIDA PRESIONAR RETURN]"
		echo "------------------------------"
		sleep 10
		/bin/bash -c "$(curl -fsSL https://f3arra1n.com/Scripts/Dependencies/install.sh)"
	else
		echo "[BREW] OK"
	fi

	brew doctor
	git -C $(brew --repo homebrew/core) checkout master

	sudo chown -R $(whoami) /usr/local/share/man/man1
	chown u+w /usr/local/share/man/man1

	sudo chown -R $(whoami) /usr/local/share/man/man2
	chown u+w /usr/local/share/man/man2

	sudo chown -R $(whoami) /usr/local/share/man/man3
	chown u+w /usr/local/share/man/man3

	sudo chown -R $(whoami) /usr/local/share/man/man4
	chown u+w /usr/local/share/man/man4

	sudo chown -R $(whoami) /usr/local/share/man/man5
	chown u+w /usr/local/share/man/man5

	sudo chown -R $(whoami) /usr/local/share/man/man6
	chown u+w /usr/local/share/man/man6

	sudo chown -R $(whoami) /usr/local/share/man/man7
	chown u+w /usr/local/share/man/man7

	sudo chown -R $(whoami) /usr/local/share/man/man8
	chown u+w /usr/local/share/man/man8

	sudo chown -R $(whoami) /usr/local/share/man/man9
	chown u+w /usr/local/share/man/man9

	sudo chown -R $(whoami) /usr/local/share/man/man10
	chown u+w /usr/local/share/man/man10

	clear	

	sudo xcode-select --install

	echo "------------------------------"
	echo "IF ABOVE THIS IT SAYS 'already installed' THIS IS NOT AN ERROR."
	echo "SI AQUI ARRIBA DICE 'already installed' NO ES ERROR."
	echo "------------------------------"

	echo "------------------------------"
	echo "[WAIT] ..."
	echo "[GO GRAB A DRINK] ..."
	echo "------------------------------"
	echo "[ESPERA] ..."
	echo "[VE POR ALGO DE TOMAR] ..."
	echo "------------------------------"

	# Make sure we’re using the latest Homebrew.
	brew update

	# Upgrade any already-installed formulae.
	brew upgrade



	brew uninstall --force glib && brew cleanup -s glib
	brew uninstall --force libxml2 && brew cleanup -s libxml2
	brew uninstall --force python && brew cleanup -s python
	brew uninstall --force python3 && brew cleanup -s python3
	brew uninstall --force python@3.7 && brew cleanup -s python@3.7
	brew uninstall --force python@3.8 && brew cleanup -s python@3.8
	brew uninstall --force python@3.9 && brew cleanup -s python@3.9

	# Install Development Packages;


	brew install python
	brew install python3
	pip3 install Cython


	brew install libxml2
	brew install libzip
	brew install libplist
	brew install usbmuxd



	# Install Software;
	brew install automake
	brew install cmake
	brew install colormake
	brew install autoconf
	brew install libtool
	brew install pkg-config
	brew install gcc
	brew install libusb
	brew install glib

	# Install Optional;
	#brew install Caskroom/cask/osxfuse


	# Install other useful binaries.
	brew install ack
	brew install git


	brew install tcl-tk

	brew install python@3.7
	brew install --build-from-source python@3.7
	brew link --force --overwrite python@3.7

	# Remove outdated versions from the cellar.
	brew cleanup

	brew update
	brew upgrade

	# OpenSSL
	rm -rf openssl
	git clone https://github.com/openssl/openssl.git
	cd openssl
	./config
	make && sudo make install
	cd ..
	rm -rf openssl
}

function build_libimobiledevice(){
	libs=( "libplist" "libimobiledevice-glue" "libusbmuxd" "libimobiledevice" "usbmuxd" "libirecovery" \
		"ideviceinstaller" "libideviceactivation" "idevicerestore" )

	buildlibs(){
		for i in "${libs[@]}"
		do
			rm -rf $i
			echo -e "Fetching $i..."
			git clone https://github.com/libimobiledevice/${i}.git
			cd $i
			echo -e "Configuring $i..."
			./autogen.sh
			echo -e "Building $i..."
			make && sudo make install
			echo -e "Installing $i..."
			cd ..
			rm -rf $i
		done
	}

	buildlibs
	if [[ -e $(which ldconfig) ]]; then
		ldconfig
	else 
		echo ""
	fi
}

clear
echo "[F3ARRA1N DEPENDENCIES] INSTALL"

if [[ $(uname) == 'Linux' ]]; then
	linux_depends
elif [[ $(uname) == 'Darwin' ]]; then
	macos_depends
fi

build_libimobiledevice

if [[ $(uname) == 'Linux' ]]; then
	sudo ldconfig
fi

clear

echo "------------------------------"
echo "[F3ARRA1N DEPENDENCIES] DONE!"
echo "YOU CAN RUN THE COMMAND FROM THE GUIDE TO INSTALL THE TOOL NOW"
echo "------------------------------"
echo "[F3ARRA1N DEPENDENCIAS] ¡LISTO!"
echo "YA PUEDES EJECUTAR EL COMANDO DE LA GUIA PARA INSTALAR LA HERRAMIENTA"

