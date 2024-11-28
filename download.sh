#!/bin/bash

URL="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2024.2.1.11/android-studio-2024.2.1.11-linux.tar.gz"
FILE_NAME=$(basename $URL)
SHA1=5031a03e891791e18a1baabae56f41eed22cd929
MD5=51d8a90833b99194bbf3d1dfb657bd72

if which sha1sum > /dev/null
then
    SUM_TOOL=sha1sum
    SUM=$SHA1
elif which md5sum > /dev/null
then
    SUM_TOOL=md5sum
    SUM=$MD5
else
    echo "No checksum tools were found!"
    exit 1
fi

if which curl >/dev/null
then
    curl $URL -L -o $FILE_NAME
elif which wget >/dev/null
then
    wget $URL
else
    echo "Nor curl or wget are installed"
    exit 2
fi

FILE_SUM=$($SUM_TOOL $FILE_NAME | cut -d ' ' -f1)

if [[ $FILE_SUM != $SUM ]];
then
    printf "%s: checksum incorrect. %s != %s\n" $FILE_NAME $FILE_SUM $SUM
    exit 1
fi