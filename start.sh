#!/bin/bash

xhost_output=$(xhost)

if [[ $xhost_output != *"LOCAL:"* ]];
then
    read -p "This will add local:docker to xhost, continue? (y/n) " resp
    
    if [[ ${resp,,} == "y" || ${resp,,} == "yes" ]];
    then
        xhost +local:docker
    else
        echo "Cancelled by user"
        exit 0
    fi
fi


DATA_DIR=$HOME/.android-studio
DATA_SUBDIRS=(.android Android .config .local .gradle .java)

if [ ! -d $DATA_DIR ];
then
    mkdir $DATA_DIR
fi

if [ ! -d ~/AndroidStudioProjects ];
then
    mkdir ~/AndroidStudioProjects
fi

for SUBDIR in ${DATA_SUBDIRS[@]}
do
    if [ ! -d $DATA_DIR/$SUBDIR ];
    then
        mkdir $DATA_DIR/$SUBDIR
    fi
done

# OLD HABIT
VOLUME_ARGS=""

for SUBDIR in ${DATA_SUBDIRS[@]}
do
    VOLUME_ARGS="${VOLUME_ARGS} -v ${DATA_DIR}/${SUBDIR}:/home/ubuntu/${SUBDIR}"
done

docker run -it --rm \
--env WAYLAND_DISPLAY=$WAYLAND_DISPALY -v /run/user/1000/wayland-$WAYLAND_DISPLAY:/run/user/1000/wayland-$WAYLAND_DISPLAY \
--env DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --device /dev/dri --device /dev/kvm \
-v ~/AndroidStudioProjects:/home/ubuntu/AndroidStudioProjects $VOLUME_ARGS android-studio:2024.2.1.11
