#!/bin/bash

ARCHIVE=$(ls android-studio*.tar.gz 2>/dev/null)

if [[ $? -ne 0 || -z $ARCHIVE ]];
then
    echo "No android studio archive found"
    read -p "Run download.sh? (y/n) " resp
    if [[ ${resp,,} == "y" || ${resp,,} == "yes" ]];
    then
        bash download.sh
        if [ $? -ne 0 ];
        then
            exit 1
        fi
        exec "$0" "$@"
    fi
    exit 1
fi

VERSION=$(echo $ARCHIVE | awk -F '-' '{print $3}')

docker build -t android-studio:$VERSION .