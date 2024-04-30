#!/bin/bash

DIR=./AGDTMP

rm -rf $DIR
mkdir $DIR

id=1185

for i in `seq 63 69`
do
    unzip -d $DIR *$i.zip
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
mv CHOPPER CHOPDEF
mv DIRTYDOZER2 DIRTYD2

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

#mv AKANE/_\ Akane.txt AKANE/_Akane.txt
#mv UFO/_\ UFO.txt UFO/_UFO.txt
#mv VAMPIRE/_\ Vampire_Vengeance.txt VAMPIRE/_Vampire_Vengeance.txt
#mv STRIKER/_\ Moritz_the_Striker.txt STRIKER/_Moritz_the_Striker.txt
#mv TOOFY3/_\ Toofys_Nutty_Nightmare.txt TOOFY3/_Toofys_Nutty_Nightmare.txt
#mv TANK/_\ Tank.txt TANK/_Tank.txt


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
    echo -e "$id,V13B1,AGD,AGD,C.Kees' AGD Ports,$title,Game,Kees van Oss,AGD/$i,8200,CH.\"$run\",Test,\"$files\",present,AGD,Yes"

    id=$((id+1))

done
