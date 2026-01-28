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
$BEEBASM -i menu.asm -o $ARCHIVE/../MENU -D atommc=1

# Compile the Splash Menu (for SDDOS2)
$BEEBASM -i menu.asm -o $ARCHIVE/MENUSDDOS2 -D sddos2=1

# Compile the Splash Menu (for SDDOS3)
$BEEBASM -i menu.asm -o $ARCHIVE/MENUSDDOS3 -D sddos3=1

# Compile the Splash Menu (for Econet)
$BEEBASM -i menu.asm -o $ARCHIVE/MENUECO -D econet=1

# Compile the Splash Menu (for GoSDC)
$BEEBASM -i menu.asm -o $ARCHIVE/MENUGOS -D gosdc=1

# Compile the Chapter Menu (for AtomMMC)
$BEEBASM -i chapter.asm -o $ARCHIVE/CHAP -D atommc=1

# Compile the Chapter Menu (for SDDOS2)
$BEEBASM -i chapter.asm -o $ARCHIVE/CHAPSDDOS2 -D sddos2=1

# Compile the Chapter Menu (for SDDOS3)
$BEEBASM -i chapter.asm -o $ARCHIVE/CHAPSDDOS3 -D sddos3=1

# Compile the Chapter Menu (for Econet)
$BEEBASM -i chapter.asm -o $ARCHIVE/CHAPECO -D econet=1

# Compile the Chapter Menu (for GoSDC)
$BEEBASM -i chapter.asm -o $ARCHIVE/CHAPGOS -D gosdc=1

# Compile the All Menu (for AtomMMC)
$BEEBASM -i chapter.asm -o $ARCHIVE/ALL -D Base=0x1000 -D atommc=1

# Compile the All Menu (for SDDOS2)
$BEEBASM -i chapter.asm -o $ARCHIVE/ALLSDDOS2  -D Base=0x1000 -D sddos2=1

# Compile the All Menu (for SDDOS3)
$BEEBASM -i chapter.asm -o $ARCHIVE/ALLSDDOS3  -D Base=0x1000 -D sddos3=1

# Compile the All Menu (for Econet)
$BEEBASM -i chapter.asm -o $ARCHIVE/ALLECO -D Base=0x1000 -D econet=1

# Compile the All Menu (for GoSDC)
$BEEBASM -i chapter.asm -o $ARCHIVE/ALLGOS -D Base=0x1000 -D gosdc=1

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
