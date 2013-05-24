#!/bin/bash -e

DIR=MNU
# Delete the old MNU folder
rm -rf $DIR.zip MENU $DIR

# Compile the Boot Loader
../../BeebASM/beebasm/beebasm -i boot.asm

# Compile the menu data and boostrap files
java -jar ../java/atommenu/atommenu.jar ../catalog/AtomSoftwareCatalog.csv $DIR BOOT.bin

# Add in splash screens
cp splash/SCREEN1.ATM $DIR/SCREEN1
cp splash/SCREEN2.ATM $DIR/SCREEN2
cp splash/SCREEN3.ATM $DIR/SCREEN3
cp splash/HELP.ATM $DIR/HELP

# Compile the Assembly file
../../BeebASM/beebasm/beebasm -i menumc.asm
mv MENUMC $DIR

# Compile the Stanalone Menu
../../BeebASM/beebasm/beebasm -i menu.asm

# Translate the Basic from text to ATM
java -jar ../java/atombasic/atombasic.jar menu.bas MENUBAS 2900 ce86

# Translate the Help from text to ATM
java -jar ../java/atombasic/atombasic.jar helpgen.bas HELPGEN 2900 ce86
mv HELPGEN $DIR

# Also copy to Atomulator
cp -a MENU MENUBAS $DIR ../../Atomulator/mmc

# Zip everything up
zip -qr $DIR.zip MENU MENUBAS $DIR

# Copy to somewhere nice
cp $DIR.zip $HOME

# Cleanup
rm -rf MENU MENUBAS BOOT.bin $DIR


