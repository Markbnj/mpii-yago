#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# This program will sync the file urls listed in the yago-files.txt
# file with the files present in ttl/ and download/extract any that
# are missing.
#
# The yago-files.txt file should list YAGO database file urls one
# per line. Blank lines and lines beginning with the hash "#" are
# ignored.

YAGO_MANIFEST=yago-files.txt
YAGO_DIR=ttl

# check that the commands we need to run are present
ensure_prereqs() {
    if ! hash 7za 2>/dev/null; then
        echo "Error: '7za' command not found."
        echo "This program requires p7zip-full to be installed."
        exit 1
    fi
}

ensure_prereqs

# load the file manifest
if [ ! -e ${YAGO_MANIFEST} ]; then
    echo "Yago manifest file ${YAGO_MANIFEST} not found; exiting."
    exit 1
else
    echo "Syncing YAGO database files with ${YAGO_MANIFEST}..."
fi
if [ ! -e ${YAGO_DIR} ]; then
    mkdir ${YAGO_DIR}
fi
while IFS=''; read -r file_url || [[ -n "$file_url" ]]; do
    if [ ! -z $file_url ]; then
        if  [[ ! $file_url == \#* ]]; then
            IFS=' '
            parts=(${file_url//\// })
            file_name=${parts[-1]}
            let "len=${#file_name} - 3"
            uc_file_name=${file_name:0:$len}
            printf "$uc_file_name "
            if [ -e "${YAGO_DIR}/${uc_file_name}" ]; then
                printf "OK\n"
            else
                if [ ! -e "${YAGO_DIR}/${file_name}" ]; then
                    printf "downloading... "
                    curl -s -o ${YAGO_DIR}/${file_name} $file_url
                fi
                printf "extracting... "
                cwd=$(pwd)
                cd ${YAGO_DIR}
                r=$(7za e ${file_name})
                rm ${file_name}
                cd ${cwd}
                printf "OK\n"
            fi
        fi
    fi
done < "./${YAGO_MANIFEST}"
echo "Completed"