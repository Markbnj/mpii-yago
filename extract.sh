#!/bin/bash
set -ueo pipefail
IFS=$'\n\t'

if [ ! -e $1 ]; then
    echo "extract: source directory $1 not found"
    exit 1
fi
echo "Extracting YAGO TTL files..."
cwd=$(pwd)
cd $1
for file_name in *.7z; do
    printf "extracting ${file_name}... "
    7za e ${file_name}
    rm ${file_name}
done
cd ${cwd}
echo "Completed"
