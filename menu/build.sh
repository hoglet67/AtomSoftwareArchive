#!/bin/bash -e

ARCHIVE=../archive/archive

DIR=MNU

VERSION=$*

echo "Building with version $VERSION"

# Delete the old MNU folders
rm -rf $ARCHIVE/MENU
rm -rf $ARCHIVE/HELP
rm -rf $ARCHIVE/$DIR[A-Z]

# rm -rf $HOME/$DIR.zip

# Compile the Boot Loader
../../BeebASM/beebasm/beebasm -i boot.asm

# Compile the ROM Boot Loader
../../BeebASM/beebasm/beebasm -i bootrom.asm

# Add in help screens
cp splash/HELP.ATM $ARCHIVE/HELP

# Compile the Standalone Menu (for AtomMMC)
../../BeebASM/beebasm/beebasm -i menu_atommc.asm
mv MENU $ARCHIVE

# Compile the Standalone Menu (for SDDOS)
../../BeebASM/beebasm/beebasm -i menu_sddos.asm
mv MENUSD $ARCHIVE

# Translate the Help from text to ATM
#java -jar ../java/atombasic/atombasic.jar helpgen.bas HELPGEN 2900 ce86
#mv HELPGEN $DIR

# Compile the menu data and boostrap files
java -jar ../java/atommenu/atommenu.jar ../catalog/AtomSoftwareCatalog.csv $ARCHIVE BOOT.bin BOOTROM.bin "$VERSION"

# Also copy to Atomulator
cp -a $ARCHIVE/MENU $ARCHIVE/HELP $ARCHIVE/$DIR[A-Z] ../../Atomulator/mmc

# Zip everything up somewhere nice
# zip -qr $HOME/$DIR.zip $ARCHIVE/MENU $ARCHIVE/HELP $ARCHIVE/$DIR[A-Z]



