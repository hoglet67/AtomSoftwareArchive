#!/bin/bash -e

ARCHIVE=ASA

##############################################################
# Update the AGD Carousel
##############################################################

# Note we need to do this at package time as the econet screen paths
# are based on the title id which is quite fluid.

./scripts/agd_screen_paths.sh

java -jar ../java/atombasic/atombasic.jar ../agdzips/SHOW1.bas $ARCHIVE/AGD/SHOW1 2900 ce86

n=`wc -l <list.atommc`
n=$((n - 1))
for i in SHOW2 SHOW3
do
    cat ../agdzips/$i.bas list.atommc | sed "s/NNNNN/$n/" > $i.bas
    java -jar ../java/atombasic/atombasic.jar $i.bas $ARCHIVE/AGD/$i 2900 ce86
    rm -f $i.bas
done

rm -f list.atommc

n=`wc -l <list.econet`
n=$((n - 1))
for i in SHOW2E SHOW3E
do
    cat ../agdzips/$i.bas list.econet | sed "s/NNNNN/$n/" > $i.bas
    java -jar ../java/atombasic/atombasic.jar $i.bas $ARCHIVE/AGD/$i 2900 ce86
    rm -f $i.bas
done

rm -f list.econet

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

zip -qr $ARCHIVE.zip MENU LIB MANPAGES $ARCHIVE

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

MMC=../../Atomulator/mmc
if [ -d "$MMC" ]; then
    cp -a MENU ASA $MMC
else
    echo "Skipping copy to Atomulator"
fi
