#!/bin/bash

DIR=../archive/archive/AGD

rm -rf $DIR
mkdir -p $DIR

find . -name '*.zip' -print0 | xargs -n1 -0 unzip -q -d $DIR

cd $DIR

# Rename directorys containing a - characters
DIRS=$(find . -maxdepth 1 -type d  | sort  | cut -c3- | egrep "-")
for i in $DIRS
do
 mv $i $(echo $i | tr -d '-')
done

# Rename directorys that will clash when truncates to 7 characters
mv SORCERESS SORCE
mv SORCERESS2 SORCE2
mv LDRAGON2 LDRAG2


# Rename directorys > 7 chars
DIRS=$(find . -maxdepth 1 -type d  | sort  | cut -c3-)
for i in $DIRS
do
    mv $i tmp
    mv tmp $(echo $i | cut -c1-7 | tr "a-z" "A-Z")
done

rm -f */*.DSK
rm -f */*.CSW


# Create some missing _.txt files
touch LADDER/_Diamond_Geezer.txt
touch LDRAG2/_Little_Dragon_2.txt
touch LUMOS/_The_Treasure_of_Lumos.txt
touch MALIGNA/_The_Malignant_Core.txt

# Put back some spaces
mv AEON1/_Aeon.txt AEON1/_Aeon1.txt
mv AEON2/_Aeon.txt AEON2/_Aeon2.txt
mv AEON3/_Aeon.txt AEON3/_Aeon3.txt
mv AEON4/_Aeon.txt AEON4/_Aeon4.txt
mv BALDY/_BaldyZX.txt BALDY/_Baldy_ZX.txt
mv BEANBRO/_BeanBrothers.txt  BEANBRO/_Bean_Brothers.txt
mv CYBER/_CyberMania.txt CYBER/_Cyber_Mania.txt
mv DAVEY/_DaveyDudds.txt DAVEY/_Davey_Dudds.txt
mv DBUBBLE/_DoubleBubble.txt DBUBBLE/_Double_Bubble.txt
mv DRAIDER/_DungeonRaiders.txt DRAIDER/_Dungeon_Raiders.txt
mv DTRICKS/_DarkTricks.txt DTRICKS/_Dark_Tricks.txt
mv ESCAPE/_SpaceEscape.txt ESCAPE/_Space_Escape.txt
mv GIFTHUN/_ChristmasGiftHunt.txt GIFTHUN/_Christmas_Gift_Hunt.txt
mv GRUMPY/_GrumpySanta.txt GRUMPY/_Grumpy_Santa.txt
mv JUMPCOL/_JumpCollision.txt JUMPCOL/_Jump_Collision.txt
mv MIKE/_MikeTheGuitar.txt MIKE/_Mike_The_Guitar.txt
mv NIGHTST/_NightStalker\ ZX.txt NIGHTST/_Night_Stalker_ZX.txt
mv PINKPIL/_PinkPillsMoritzMeds_Instructions.txt PINKPIL/_Pink_Pills_Moritz_Meds.txt
mv ROBOPRO/_RoboProbe.txt ROBOPRO/_Robo_Probe.txt
mv SPACEJU/_SpaceJunk.txt SPACEJU/Space_Junk.txt 


id=908

# Extract titles
DIRS=$(find [A-Z]* -maxdepth 1 -type d  | sort)
for i in $DIRS
do
    cd $i
    title=$(ls *.txt | cut -c2- | tr "_" " " | sed 's/_Instructions//' | sed 's/.txt//')
    #echo -e "=========================="
    #echo -e "$i"
    #echo -e "$title" | cut -c1-26
    mv *.txt README.TXT
    #
    run=$(find [A-Za-z]* | sort | grep RUN)
    files=$(find [A-Za-z]* | sort | grep -v README)
    cd ..
    echo -e "$id,V11B2,AGD,AGD,B.Modern Creations/Ports,$title,Game,Kees van Oss,AGD/$i,8200,CH.\"$run\",Test,\"$files\",present,AGD,Yes"
    
    id=$((id+1))
    
done

