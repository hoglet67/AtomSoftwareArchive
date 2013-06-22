#!/bin/bash -e

DIR=MNU

VERSION=$*

echo "Building with version $VERSION"

# Delete the old MNU folders
rm -rf $DIR.zip MENU $DIR[A-Z]

# Compile the Boot Loader
../../BeebASM/beebasm/beebasm -i boot.asm

# Compile the menu data and boostrap files
java -jar ../java/atommenu/atommenu.jar ../catalog/AtomSoftwareCatalog.csv $DIR BOOT.bin "$VERSION"

# Add in help screens
cp splash/HELP.ATM HELP

# Compile the Stanalone Menu
../../BeebASM/beebasm/beebasm -i menu.asm

# Translate the Help from text to ATM
#java -jar ../java/atombasic/atombasic.jar helpgen.bas HELPGEN 2900 ce86
#mv HELPGEN $DIR

# Also copy to Atomulator
cp -a MENU HELP $DIR[A-Z] ../../Atomulator/mmc

# Zip everything up
zip -qr $DIR.zip MENU HELP $DIR[A-Z]

# Copy to somewhere nice
cp $DIR.zip $HOME

# Cleanup
rm -rf MENU HELP BOOT.bin $DIR[A-Z]


