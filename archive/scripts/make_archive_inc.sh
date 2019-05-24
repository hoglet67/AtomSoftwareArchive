#!/bin/bash -e


ARCHIVE=archive

##############################################################
# Build the menu
##############################################################
pushd ../menu
mkdir -p disks
./build.sh "$*"
popd

##############################################################
# Zip up the archive
##############################################################

pushd $ARCHIVE
find . -type f | sort | zip -@ ../$ARCHIVE.zip
popd

zip -qr ~/$ARCHIVE_SDDOS.zip $ARCHIVE.img

##############################################################
# Rename up the archive
##############################################################

NAME=AtomSoftwareArchive_$(date +"%Y%m%d_%H%M")_$1


mv $ARCHIVE.zip $NAME.zip
mv ${ARCHIVE}_ECONET.zip ${NAME}_ECONET.zip
zip -qr ${NAME}_JS.zip $ARCHIVE.js
zip -qr ${NAME}_SDDOS2.zip $ARCHIVE.img
pushd ../menu
zip -qr ../archive/${NAME}_SDDOS3.zip disks
popd 
ls -l ${NAME}*

##############################################################
# Deploy to Atomulator for testing
##############################################################

pushd $ARCHIVE
cp -a * ../../../Atomulator/mmc
popd

