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
rm -f disks/*
./build.sh $*
popd

##############################################################
# Name the archive
##############################################################

NAME=AtomSoftwareArchive_$(date +"%Y%m%d_%H%M")_$1

shopt -s nocasematch

##############################################################
# Package ECONET version
##############################################################

if [[ $# -lt 2 ]] || [[ "$2" =~ "ECONET" ]]; then
    # Rename the generated ZIP file
    mv ${ARCHIVE}_ECONET.zip ${NAME}_ECONET.zip
    # Generate the AFS0 File Server Disk Image
    SCSIDIR=BeebSCSI0
    mkdir -p ${SCSIDIR}
    unzip -d ${SCSIDIR} -o ../econet/scsi0.dat.zip
    cp -a ../econet/scsi0.dsc ${SCSIDIR}
    java -jar ../java/afsutils/afsutils.jar ${SCSIDIR}/scsi0.dat ${NAME}_ECONET.zip
    zip -r ${NAME}_BEEBSCSI0.zip ${SCSIDIR}
    rm -f ${SCSIDIR}/*
    rmdir ${SCSIDIR}
fi

##############################################################
# Package JS version
##############################################################

if [[ $# -lt 2 ]] || [[ "$2" =~ "JS" ]]; then
    zip -qr ${NAME}_JS.zip $ARCHIVE.js
fi

##############################################################
# Package SDDOS2 version
##############################################################

if [[ $# -lt 2 ]] || [[ "$2" =~ "SDDOS2" ]]; then
    zip -qr ${NAME}_SDDOS2.zip $ARCHIVE.img
fi

##############################################################
# Package SDDOS3 version
##############################################################

if [[ $# -lt 2 ]] || [[ "$2" =~ "SDDOS3" ]]; then
    mv ${ARCHIVE}_SDDOS3.zip ${NAME}_SDDOS3.zip
fi

##############################################################
# Package GOSDC version
##############################################################

if [[ $# -lt 2 ]] || [[ "$2" =~ "GOSDC" ]]; then
    zip -qr ${NAME}_GoSDC.zip ${ARCHIVE}.gosdc
fi


##############################################################
# Package ATOMMC version
##############################################################

if [[ $# -lt 2 ]] || [[ "$2" =~ "ATOMMC" ]]; then
    zip -qr $NAME.zip MENU LIB MANPAGES $ARCHIVE

    # Deploy to Atomulator for testing
    MMC=../../Atomulator/mmc
    if [ -d "${MMC}" ]; then
        rm -rf ${MMC}/ASA
        unzip -o -q -d ${MMC} ${NAME}.zip
    else
        echo "Skipping copy to Atomulator"
    fi

fi

##############################################################
# List the files created
##############################################################

ls -l ${NAME}*
