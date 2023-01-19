#!/bin/bash

# Manually download games from Itch and extract Z5 files to games/
#
#    Hibernated
#        https://8bitgames.itch.io/hibernated1
#        ===> games/hibernated1.z5
#
#    The Job
#        https://fredrikr.itch.io/the-job
#        ===> games/thejob_R5.z5

#########################################################
# Download OZMOO
#########################################################

OZMOO=stardot-ozmoo-preview-11.39-beta-1
if [ ! -d ozmoo ]
then
    wget -O ozmoo.zip https://github.com/ZornsLemma/ozmoo/archive/refs/tags/$OZMOO.zip
    unzip ozmoo.zip
    rm -f ozmoo.zip
    mv ozmoo-$OZMOO ozmoo
fi


#########################################################
# Download Games
#########################################################

if [ ! -d downloads ]
then
    mkdir -p downloadsI have just acquired a book of Atom programmes called 39 Tested Programs for the Acorn Atom.


    cd downloads
    # Alien Research Centre 3 and Behind Closed Doors 9 were posted to stardot
    wget -O balrog.zip https://stardot.org.uk/forums/download/file.php?id=60993
    unzip balrog.zip
    rm -f balrog.zip
    # Calypso was poster to stardot
    wget -O calypso.zip https://stardot.org.uk/forums/download/file.php?id=59155
    unzip calypso.zip
    rm -f calypso.zip
    # Classic Adventure
    wget https://raw.githubusercontent.com/sugarlabs/Frotz/master/Advent.z5
    # Infocom
    wget https://eblong.com/infocom/gamefiles/beyondzork-r60-s880610.z5
    wget https://eblong.com/infocom/gamefiles/hitchhiker-invclues-r31-s871119.z5
    wget https://eblong.com/infocom/gamefiles/hollywoodhijinx-r37-s861215.z3
    wget https://eblong.com/infocom/gamefiles/leathergoddesses-invclues-r4-s880405.z5
    wget https://eblong.com/infocom/gamefiles/planetfall-invclues-r10-s880531.z5
    wget https://eblong.com/infocom/gamefiles/wishbringer-invclues-r23-s880706.z5
    wget https://eblong.com/infocom/gamefiles/zork1-invclues-r52-s871125.z5
    wget https://eblong.com/infocom/gamefiles/zork2-r48-s840904.z3
    wget https://eblong.com/infocom/gamefiles/zork3-r17-s840727.z3
    cd ..
fi

#########################################################
# Build Games
#########################################################

OPTIONS="-p --no-tube-cache --no-history --osrdch"

mkdir -p disks

cd ozmoo

echo Building Adventure...
python make-acorn.py $OPTIONS --title "Adventure" ../downloads/Advent.z5 ../disks/ADVENT.ssd

echo Building Alien Research Centre 3...
python make-acorn.py $OPTIONS --title "Alien Research Centre 3" ../downloads/arc3d.z3 ../disks/ARC3.ssd

echo Building Behind Closed Doors 9...
python make-acorn.py $OPTIONS --title "Behind Closed Doors 9" ../downloads/bcd9b.z3 ../disks/BCD9.ssd

echo Building Beyond Zork...
python make-acorn.py $OPTIONS --title "Beyond Zork" ../downloads/beyondzork-r60-s880610.z5 ../disks/BEYZORK.dsd

echo Building Calypso...
python make-acorn.py $OPTIONS --title "Calypso" ../downloads/calypso.z5 ../disks/CALYPSO.ssd

if [ -f ../games/hibernated1.z5 ]
then
    echo Building Hibernated 1 - Directors Cut...
    python make-acorn.py  $OPTIONS --title "Hibernated 1 - Directors Cut" ../games/hibernated1.z5 ../disks/HIBER1.ssd
else
    echo Skipping Hibernated 1 - Directors Cut...
fi

echo Building The Hitchhikers Guide to the Galaxy...
python make-acorn.py $OPTIONS --title "The Hitchhikers Guide to the Galaxy" ../downloads/hitchhiker-invclues-r31-s871119.z5 ../disks/HITCH.dsd

echo Building Hollywood Hijinx...
python make-acorn.py $OPTIONS --title "Hollywood Hijinx" ../downloads/hollywoodhijinx-r37-s861215.z3 ../disks/HOLLY.ssd

if [ -f ../games/thejob_R5.z5 ]
then
    echo Building The Job R5...
    python make-acorn.py $OPTIONS --title "The Job R5" ../games/thejob_R5.z5 ../disks/THEJOB.ssd
else
    echo Skipping The Job R5...
fi

echo Building Leather Goddesses of Phobos...
python make-acorn.py $OPTIONS --title "Leather Goddesses of Phobos" ../downloads/leathergoddesses-invclues-r4-s880405.z5 ../disks/LEATHER.dsd

echo Building Planetfall...
python make-acorn.py $OPTIONS --title "Planetfall" ../downloads/planetfall-invclues-r10-s880531.z5 ../disks/PLANET.ssd

echo Building Wishbringer...
python make-acorn.py $OPTIONS --title "Wishbringer" ../downloads/wishbringer-invclues-r23-s880706.z5 ../disks/WISH.dsd

echo Building Zork1: The Great Underground Empire...
python make-acorn.py $OPTIONS --title "Zork1: The Great Underground Empire" ../downloads/zork1-invclues-r52-s871125.z5 ../disks/ZORK1.ssd

echo Building Zork2: The Wizard of Frobozz...
python make-acorn.py $OPTIONS --title "Zork2: The Wizard of Frobozz" ../downloads/zork2-r48-s840904.z3 ../disks/ZORK2.ssd

echo Building Zork3: The Dungeon Master...
python make-acorn.py $OPTIONS --title "Zork3: The Dungeon Master" ../downloads/zork3-r17-s840727.z3 ../disks/ZORK3.ssd

#########################################################
# Cleanup
#########################################################

rm -f temp/*

#########################################################
# Convert to Atom
#########################################################

cd ../asm
beebasm -i boot.asm
beebasm -i loader.asm

cd ../disks

build=../build

mkdir -p ${build}

shopt -s nullglob

# SSDs

for i in *.ssd
do
    name=${i%.ssd}
    mkdir -p tmp
    java -jar ../../java/atomtape/atomtape.jar -a $i tmp
    mkdir ${build}/${name}
    cp tmp/${name}/OZMOO2P ${build}/${name}
    cp $i ${build}/${name}/GAME.DSK
    cp ../asm/BOOT ../asm/LOADER ${build}/${name}
    rm -rf tmp
done

# DSDs

for i in *.dsd
do
    name=${i%.dsd}
    mkdir -p tmp
    beeb split_dsd $i ${name}.ssd ${name}2.ssd
    java -jar ../../java/atomtape/atomtape.jar -a ${name}.ssd tmp
    rm -f ${name}.ssd ${name}2.ssd
    mkdir ${build}/${name}
    cp tmp/${name}/OZMOO2P ${build}/${name}
    cp $i ${build}/${name}/GAME.DSK
    cp ../asm/BOOT ../asm/LOADER ${build}/${name}
    rm -rf tmp
done
