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
$BEEBASM -i menu.asm -o $ARCHIVE/../MENU

# Compile the Splash Menu (for SDDOS)
$BEEBASM -i menu.asm -o $ARCHIVE/MENUSD -D sddos=1

# Compile the Splash Menu (for Econet)
$BEEBASM -i menu.asm -o $ARCHIVE/MENUECO -D econet=1

# Compile the Splash Menu (for GoSDC)
$BEEBASM -i menu.asm -o $ARCHIVE/MENUGOS -D gosdc=1

# Compile the Chapter Menu (for AtomMMC)
$BEEBASM -i chapter.asm -o $ARCHIVE/CHAP

# Compile the Chapter Menu (for SDDOS)
$BEEBASM -i chapter.asm -o $ARCHIVE/CHAPSD -D sddos=1

# Compile the Chapter Menu (for Econet)
$BEEBASM -i chapter.asm -o $ARCHIVE/CHAPECO -D econet=1

# Compile the Chapter Menu (for GoSDC)
$BEEBASM -i chapter.asm -o $ARCHIVE/CHAPGOS -D gosdc=1

# Compile the All Menu (for AtomMMC)
$BEEBASM -i chapter.asm -o $ARCHIVE/ALL -D Base=1024

# Compile the All Menu (for SDDOS)
$BEEBASM -i chapter.asm -o $ARCHIVE/ALLSD  -D Base=1024 -D sddos=1

# Compile the All Menu (for Econet)
$BEEBASM -i chapter.asm -o $ARCHIVE/ALLECO -D Base=1024 -D econet=1

# Compile the All Menu (for GoSDC)
$BEEBASM -i chapter.asm -o $ARCHIVE/ALLGOS -D Base=1024 -D gosdc=1

# Translate the Help from text to ATM
#java -jar ../java/atombasic/atombasic.jar helpgen.bas HELPGEN 2900 ce86
#mv HELPGEN $DIR

# Compile the menu data and boostrap files
java -jar ../java/atommenu/atommenu.jar ../catalog/AtomSoftwareCatalog.csv $ARCHIVE BOOT.bin BOOTROM.bin "$VERSION"

# Remove unnecessary files from the root directory
rm -f $ARCHIVE/HELP
rm -f $ARCHIVE/CHAP*
rm -f $ARCHIVE/ALL*
rm -f $ARCHIVE/MENU[A-Z]*
