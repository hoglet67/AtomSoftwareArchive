#!/bin/bash -e

ARCHIVE=../archive/ASA

DIR=MNU

VERSION=$*

BEEBASM=beebasm

echo "Building with version $VERSION"

# Delete the old MNU folders
rm -rf $ARCHIVE/MENU
rm -rf $ARCHIVE/HELP
rm -rf $ARCHIVE/$DIR[A-Z]

# rm -rf $HOME/$DIR.zip

# Compile the Boot Loader
$BEEBASM -i boot.asm

# Compile the ROM Boot Loader
$BEEBASM -i bootrom.asm

# Add in help screens
cp splash/HELP.ATM $ARCHIVE/HELP

# Compile the Splash Menu (for AtomMMC)
$BEEBASM -i menu_atommc.asm
mv MENU $ARCHIVE/..

# Compile the Splash Menu (for SDDOS)
$BEEBASM -i menu_sddos.asm
mv MENUSD $ARCHIVE

# Compile the Splash Menu (for Econet)
$BEEBASM -i menu_econet.asm
mv MENUECO $ARCHIVE

# Compile the Splash Menu (for GoSDC)
$BEEBASM -i menu_gosdc.asm
mv MENUGOS $ARCHIVE

# Compile the Splash Menu (for AtomMMC)
$BEEBASM -i chapter_atommc.asm
mv CHAP $ARCHIVE

# Compile the Splash Menu (for SDDOS)
$BEEBASM -i chapter_sddos.asm
mv CHAPSD $ARCHIVE

# Compile the Splash Menu (for Econet)
$BEEBASM -i chapter_econet.asm
mv CHAPECO $ARCHIVE

# Compile the Splash Menu (for GoSDC)
$BEEBASM -i chapter_gosdc.asm
mv CHAPGOS $ARCHIVE

# Translate the Help from text to ATM
#java -jar ../java/atombasic/atombasic.jar helpgen.bas HELPGEN 2900 ce86
#mv HELPGEN $DIR

# Compile the menu data and boostrap files
java -jar ../java/atommenu/atommenu.jar ../catalog/AtomSoftwareCatalog.csv $ARCHIVE BOOT.bin BOOTROM.bin "$VERSION"

# Remove unnecessary files from the root directory
rm -f $ARCHIVE/HELP
rm -f $ARCHIVE/CHAP
rm -f $ARCHIVE/MENUECO
rm -f $ARCHIVE/MENUSD
rm -f $ARCHIVE/MENUGOS
rm -f $ARCHIVE/CHAPECO
rm -f $ARCHIVE/CHAPSD
rm -f $ARCHIVE/CHAPGOS
