#!/bin/bash -e

DIR=MNU
# Delete the old MNU folder
rm -rf $DIR.zip MENU $DIR

# Compile the menu data and boostrap files
java -jar ../java/atommenu/atommenu.jar ../catalog/AtomSoftwareCatalog.csv $DIR

# Add in splash screens
cp splash/SCREEN1.ATM $DIR/SCREEN1
cp splash/SCREEN2.ATM $DIR/SCREEN2

# Compile the Assembly file
../../BeebASM/beebasm/beebasm -i menu.asm
mv MENUMC $DIR

# Translate the Basic from text to ATM
java -jar ../java/atombasic/atombasic.jar menu.bas MENU 2900 ce86

# Zip everything up
zip -qr $DIR.zip MENU $DIR

# Cleanup
rm -rf MENU $DIR

# Copy to somewhere nice
cp $DIR.zip $HOME

