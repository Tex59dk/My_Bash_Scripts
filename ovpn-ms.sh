#!/bin/bash

#https://bugs.launchpad.net/ubuntu/+source/network-manager-openvpn/+bug/606365
#http://howto.praqma.net/ubuntu/vpn/openvpn-access-server-client-on-ubuntu

#!/bin/bashset -e

function usage(){

	echo -e "\nThe script can be used to split or merge ovpn file." 
	echo -e "\nBasic Usage:\n $0 [options..] <ovpn-config-file> \n"
	echo -e "Open VPN config file can be passed either as argument or through option (--source | -s ). \n"
	echo -e "\nOptions:"
	echo -e "-p | --split - flag to specify to split ovpn file."
	echo -e "-s<filepath> | --source <filepath> - Option to pass the source ovpn file."
	echo -e "-d<folderpath> | --destination <folderpath> - Destination location where the newly created config to be stored. "
	echo -e "-m | --merge [optional parameter : auto] - simple flag to specify to merge file. takes a optional parameter [auto]."
	echo -e "if auto is set, then the script tries to identify certificates and keys from ovpn file. This can be overridded by other options."
	echo -e "--ca <filepath> - option to specify the location of the CA file. "
	echo -e "--cert <filepath>  - option to specify the location of the certificate file."
	echo -e "--key <filepath>  - option to specify the location of the key file. "
	echo -e "--tls-auth <filepath>  - option to specify the location of the tls-auth file."
	echo -e "--dh-params <filepath> - opton to specify the location of the dh params file."
	echo -e "-h | --help - Display usage instructions.\n"
	echo -e "Example usage for merge:\n"
	echo -e "$0 -m=auto -s home/openvpn/vpn.ovpn"
	echo -e "--ca home/openvpn/vpn-ca.crt"
	echo -e "-d home/openvpn/merged/ --cert home/openvpn/vpn-client.crt --key home/openvpn/vpn-client.key"
	echo -e "\n\nExample usage for split:\n"
	echo -e "$0 -s home/openvpn/vpn.ovpn -d home/openvpn/split/\n"
	exit 0;
}

PROGNAME=${0##*/}
SHORTOPTS="hm::ps:d:D:" 
LONGOPTS="help,merge::,split,source:,destination:,ca:,cert:,key:,tls-auth:,dh-params:" 
set -o errexit -o noclobber -o pipefail

OPTS=$(getopt -s bash --options $SHORTOPTS --longoptions $LONGOPTS --name $PROGNAME -- "$@" )
eval set -- "$OPTS"

#Base variable declaration
FILE=""
DESTINATION=""
MERGE=false
MERGEAUTO=false
SPLIT=false
CA=""
CERT=""
KEY=""
TLS_AUTH=""
DH=""

while true; do
  case "$1" in
  	-m | --merge )
		case "$2" in
            "" ) MERGE=true ; shift 2 ;;
            "auto" | "=auto" ) MERGE=true ; MERGEAUTO=true ; shift 2 ;;
        esac ;;
    -p | --split ) SPLIT=true; shift ;;
    -s | --source ) FILE="$2"; shift 2 ;;
    -d | --destination ) DESTINATION="$2"; shift 2 ;;
	-h | --help )    usage; shift ;;
	--ca ) CA="$2";shift 2 ;;
    --cert ) CERT="$2";shift 2 ;;
    --key ) KEY="$2";shift 2 ;;
    --tls-auth ) TLS_AUTH="$2";shift 2 ;;
    --dh-params ) DH="$2";shift 2 ;;
    -- ) shift; break ;;
    * )  break ;;
  esac
done

# if both merge and split flags are set then throw error
if [ "$MERGE" = true ] && [ "$SPLIT" = true ]; then
		echo "Cannot set flag merge and split at the same time."
		exit 1
fi

# if no flags are set then throw error
if [ "$MERGE" = false ] && [ "$SPLIT" = false ]; then
		echo "Atlest one of the merge or split flag must be set."
		exit 1
fi

# If argument is passed to the script, the source set through options is overridden by argument value.
# argument takes priority.
if [ ! -z "$1" ];then
	FILE="$1"
fi

# Check if the file parameter is not empty
if [ -z "$FILE" ];then
	echo "Filepath of openvpn config is mandatory."
	exit 1
fi

# If Destination folder is specified then we check whether the folder is there, if not the folder is created.
if [ ! -z "$DESTINATION" ] && [ ! -d "$DESTINATION" ];then
	mkdir -p $DESTINATION
	if [ $? -ne 0 ];then
    	echo "Creating destination directory failed."
    	exit 1
	fi
	DESTINATION="$(readlink -f $DESTINATION)"

fi

if [ ! -z "$DESTINATION" ] && [ -d "$DESTINATION" ];then
	
	DESTINATION="$(readlink -f $DESTINATION)"
fi

# If Destination is empty then create files in the same directory as of source file
if [ -z "$DESTINATION" ];then
	
	DESTINATION="$(dirname "$(readlink -f $FILE)")"
fi

if [ ! -f "$FILE" ];then
	echo "Invalid file name : $FILE"
		exit 1
fi

FULLFILENAME=$(basename $FILE)
FILENAME="${FULLFILENAME%.*}"
EXTENSION="${FULLFILENAME##*.}"

if [ ! -z "$SPLIT" ] && [ "$SPLIT" = true ];then
	
	if [ `echo $EXTENSION | tr [:upper:] [:lower:]` = `echo "conf" | tr [:upper:] [:lower:]` ] || [ `echo $EXTENSION | tr [:upper:] [:lower:]` = `echo "ovpn" | tr [:upper:] [:lower:]` ];then
    	
    		NEWPATH=${DESTINATION}/${FILENAME}-;
    		NEWFILE=${NEWPATH}updated.ovpn
		cp $FILE $NEWFILE

		if grep -q "<ca>" "$FILE"; then
   			sed '1,/<ca>/d;/<\/ca>/,$d' $FILE > ${NEWPATH}ca.crt
   			sed -i "/<ca>/,/<\/ca>/c\ca ${NEWPATH}ca.crt" ${NEWFILE}
 		fi
		if grep -q "<cert>" "$FILE"; then
   			sed '1,/<cert>/d;/<\/cert>/,$d' $FILE > ${NEWPATH}client.crt
   			sed -i "/<cert>/,/<\/cert>/c\cert ${NEWPATH}client.crt" ${NEWFILE}
 		fi
		if grep -q "<key>" "$FILE"; then
   			sed '1,/<key>/d;/<\/key>/,$d' $FILE > ${NEWPATH}client.key
   			sed -i "/<key>/,/<\/key>/c\key ${NEWPATH}client.key" ${NEWFILE}
 		fi
 		if grep -q "<tls-auth>" "$FILE"; then
		    	sed '1,/<tls-auth>/d;/<\/tls-auth>/,$d' $FILE > ${NEWPATH}ta.key
		    	sed -i "/<tls-auth>/,/<\/tls-auth>/c\tls-auth ${NEWPATH}ta.key" ${NEWFILE}
 		fi
		if grep -q "<dh>" "$FILE"; then
			sed '1,/<dh>/d;/<\/dh>/,$d' $FILE > ${NEWPATH}dh.pem
			sed -i "/<dh>/,/<\/dh>/c\dh ${NEWPATH}dh.pem" ${NEWFILE}
		fi
	    	    
	else
		echo "Invalid open vpn file extension"
		exit 1
	fi

fi

if [ ! -z "$MERGE" ] && [ "$MERGE" = true ];then
	NEWFILE=${DESTINATION}/${FILENAME}-merged.ovpn
	cp $FILE $NEWFILE

	# if merge auto is set then try to find the certificate/key path from the source ovpn file
	if [ "$MERGEAUTO" = true ];then
		for tagname in ca cert key tls_auth dh
		do
			VAR=$(echo "$tagname" | tr '[:lower:]' '[:upper:]')
			VARVAL="${!VAR}"
			if [ -z "$VARVAL" ];then
				tagname=$(echo "$tagname" |sed "s/_/-/")
				path="$(sed -n -e "s/^$tagname //p" $NEWFILE | xargs readlink -f )"
				if [ ! -z "$path" ];then
					declare $VAR=$path
				fi
			fi
		done
	fi

	if [ -z "$CA" ] &&  [ -z "$CERT" ] && [ -z "$KEY" ] && [ -z "$TLSAUTH" ];then
		echo "Atleast one option (ca,cert,key,tls-auth) parameter is required."
		exit 1
	fi

	for tagname in ca cert key tls_auth dh
	do
		#convert the tagname to upper to access the variables.
		VAR=$(echo "$tagname" | tr '[:lower:]' '[:upper:]')
		VARVAL="${!VAR}"
		if [ ! -z "$VARVAL" ] && [ ! -f "$VARVAL" ];then
			echo "Provided ${tagname} file does not exist.";
			exit 1
		fi
		#replace underscore with hypen in tagname for searching the file
		tagname=$(echo "$tagname" |sed "s/_/-/")
		if [ ! -z "$VARVAL" ];then
			#If substitution exist in the config file then replace it with inline content
			#else append the config file with the content of the file
			if grep -qE "^${tagname}[ \t]*.*$" "$NEWFILE"; then
				FULLFILENAME=$(basename $VARVAL)
				sed -i "/${tagname} .*${FULLFILENAME}/c\<${tagname}>\n<\/${tagname}>" ${NEWFILE}
				sed -i "/<${tagname}>/r ${VARVAL}" ${NEWFILE}
			else
				echo "<${tagname}>" >> ${NEWFILE}
				cat ${VARVAL} >> ${NEWFILE}
				echo "</${tagname}>" >> ${NEWFILE}
			fi
		fi

	done
	#preserve file timestamp from original file so if the original config is updated 
	#then we know that the generated one config needs to be regenerated.
	filemodtime=$(stat -c%y "$FILE" | sed 's/[ ]\+/ /g')
	touch -m -d "$filemodtime" "$NEWFILE"
fi