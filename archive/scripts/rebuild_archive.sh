#!/bin/bash -e

ARCHIVE=archive

##############################################################
# Compile the java
##############################################################

pushd ../java/atommenu
ant clean jar
popd
pushd ../java/afsutils
ant clean jar
popd

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
# Rename the archive files
##############################################################

NAME=AtomSoftwareArchive_$(date +"%Y%m%d_%H%M")_$1

mv $ARCHIVE.zip $NAME.zip
mv ${ARCHIVE}_ECONET.zip ${NAME}_ECONET.zip
zip -qr ${NAME}_JS.zip $ARCHIVE.js
zip -qr ${NAME}_SDDOS2.zip $ARCHIVE.img
pushd ../menu
zip -qr ../archive/${NAME}_SDDOS3.zip disks
popd

##############################################################
# Generate the AFS0 File Server Disk Image
##############################################################

SCSIDIR=BeebSCSI0
mkdir -p ${SCSIDIR}
unzip -d ${SCSIDIR} -o ../econet/scsi0.dat.zip
cp -a ../econet/scsi0.dsc ${SCSIDIR}
java -jar ../java/afsutils/afsutils.jar ${SCSIDIR}/scsi0.dat ${NAME}_ECONET.zip
zip -r ${NAME}_BEEBSCSI0.zip ${SCSIDIR}
rm -f ${SCSIDIR}/*
rmdir ${SCSIDIR}

##############################################################
# List the files created
##############################################################

ls -l ${NAME}*


##############################################################
# Deploy to Atomulator for testing
##############################################################

pushd $ARCHIVE
cp -a * ../../../Atomulator/mmc
popd

