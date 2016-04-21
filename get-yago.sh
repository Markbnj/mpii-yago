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

YAGO_MANIFEST=yago.manifest
YAGO_DIR=ttl

# load the file manifest
if [ ! -e ${YAGO_MANIFEST} ]; then
    echo "YAGO manifest file ${YAGO_MANIFEST} not found; exiting."
    exit 1
else
    echo "Synching YAGO files with ${YAGO_MANIFEST}..."
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
            printf "$file_name "
            if [ -e "${YAGO_DIR}/${file_name}" ]; then
                printf "OK\n"
            else
                printf "downloading... "
                curl -s -o ${YAGO_DIR}/${file_name} $file_url
                printf "OK\n"
            fi
        fi
    fi
done < "./${YAGO_MANIFEST}"
