#!/bin/bash

DIR=./AGDTMP

rm -rf $DIR
mkdir $DIR

id=1126

for i in `seq 52 58`
do
    unzip -q -d $DIR *$i.zip
done

cd $DIR

# Rename directorys containing a - characters
DIRS=$(find . -maxdepth 1 -type d  | sort  | cut -c3- | egrep "-")
for i in $DIRS
do
 j=$(echo $i | tr -d '-')
 echo "Renaming $i to $j" 1>&2
 mv $i $j
done

# Rename directorys that will clash when truncates to 7 characters
mv ALCHEMIST2 ALCHEM2
mv FUNGUS21  FUNGS21
mv FUNGUS22  FUNGS22
mv FUNGUS23  FUNGS23
mv FUNGUS24  FUNGS24
mv FUNGUS25  FUNGS25
mv LAETITIA1 LAETIT1
mv LAETITIA2 LAETIT2
mv LAETITIA3 LAETIT3
mv LAETITIA4 LAETIT4
mv DKRELOAD DKRELO

# Rename directorys > 7 chars
DIRS=$(find . -maxdepth 1 -type d  | sort  | cut -c3-)
for i in $DIRS
do
    j=$(echo $i | cut -c1-7 | tr "a-z" "A-Z")
    if [ "$i" != "$j" ]
    then
        echo "Renaming $i to $j" 1>&2
        mv $i $j
    fi
done

rm -f */*.DSK
rm -f */*.CSW

# Create some missing _.txt files
#touch LADDER/_Diamond_Geezer.txt

# Put back some spaces
#mv AEON1/_Aeon.txt AEON1/_Aeon1.txt

mv ALCHEM2/_\ Alchemist_II.txt ALCHEM2/_Alchemist_II.txt
mv AMONGBA/_\ Amongbad.txt AMONGBA/_Amongbad.txt
mv APULIJA/_Apulija13.txt APULIJA/_Apulija-13.txt
mv BLUEDAY/_Agent_Blue_Daytime_Missions.txt BLUEDAY/_Agent_Blue_Daytime.txt
mv BLUENIG/_Agent_Blue_Nighttime_Missions.txt BLUENIG/_Agent_Blue_Nighttime.txt

mv CODE112/_112Code.txt CODE112/_Code112.txt
mv FUNGS21/_Funky_Fungus_Reloaded.txt FUNGS21/_Fungus_Reloaded_1.txt
mv FUNGS22/_Funky_Fungus_Reloaded.txt FUNGS22/_Fungus_Reloaded_2.txt
mv FUNGS23/_Funky_Fungus_Reloaded.txt FUNGS23/_Fungus_Reloaded_3.txt
mv FUNGS24/_Funky_Fungus_Reloaded.txt FUNGS24/_Fungus_Reloaded_4.txt
mv FUNGS25/_Funky_Fungus_Reloaded.txt FUNGS25/_Fungus_Reloaded_Boss.txt
mv LAETIT1/_Laetitia.txt LAETIT1/_Laetitia_1.txt
mv LAETIT2/_Laetitia.txt LAETIT2/_Laetitia_2.txt
mv LAETIT3/_Laetitia.txt LAETIT3/_Laetitia_3.txt
mv LAETIT4/_Laetitia.txt LAETIT4/_Laetitia_4.txt

DIRS=$(find [A-Z]* -maxdepth 1 -type d  | sort)

for i in $DIRS
do
    if [ -d  ../../archive/kees/AGD/$i ]
    then
        echo "Directory name clash: $i" 1>&2
        exit
    fi
done

# Extract titles
for i in $DIRS
do
    cd $i
    title=$(ls *.txt | cut -c2- | tr "_" " " | sed 's/_Instructions//' | sed 's/.txt//')
    title=$(echo -e "$title" | cut -c1-26)
    #echo -e "=========================="
    #echo -e "Dir:$i"
    #echo -e "Title:$title"
    mv *.txt README.txt
    #
    run=$(find [A-Za-z0-9]* | sort | grep RUN)
    files=$(find [A-Za-z0-9]* | sort | grep -v README)
    cd ..
    echo -e "$id,V12B1,AGD,AGD,C.Kees' AGD Ports,$title,Game,Kees van Oss,AGD/$i,8200,CH.\"$run\",Test,\"$files\",present,AGD,Yes"

    id=$((id+1))

done
