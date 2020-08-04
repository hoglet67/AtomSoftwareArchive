#!/bin/bash -e

function package() {

# echo $src

 src=$1
 dst=$2

 mkdir -p $dst
 cp -a $src $dst
 rm -f $dst/*.bas
}

ARCHIVE=archive

# Define top level directories
# Nice and short for easy navigation

# Acornsoft
AS=AS
# Bug-Byte
BB=BB
# Program Power (later called Micro Power)
PP=PP
# Timedata
TD=TD
# Micromania
MM=MM
# A&F Software
AF=AF
# A&R Software
AR=AR
# Level 9 Software
L9=L9
# Retro Software
RS=RS
# Magnus Olsson
MO=MO
# Other
OTHER=OTHER
# Hopesoft
HS=HS
# Sid
SID=SID
# QUILL
QUILL=QUILL
# ASP Software
ASP=ASP
# PCW
PCW=PCW

BEEBASM=../tools/beebasm/beebasm

rm -rf $ARCHIVE
mkdir -p $ARCHIVE

##############################################################
# BBC Basic
##############################################################

mkdir -p $ARCHIVE/BBC
pushd ../bbcbasic
mkdir -p roms
$BEEBASM -i Basic2.asm
cp roms/ATBASIC2 ../archive/$ARCHIVE/BBC
popd

##############################################################
# ROMs
##############################################################

mkdir -p $ARCHIVE/ROMS
pushd ../roms
for i in `find -type f`
do
java -jar ../java/makeatm/makeatm.jar $i ../archive/$ARCHIVE/ROMS/$i A000 C2B2
done
popd

##############################################################
# Atom SID Disks (ported from BeebSID)
##############################################################

mkdir -p $ARCHIVE/$SID
cp -a ../beebsid/ATMSID* $ARCHIVE/$SID

##############################################################
# White Barrows
##############################################################

mkdir -p $ARCHIVE/$ASP
java -jar ../java/atombasic/atombasic.jar ../whitebarrows/WHITEBA.bas $ARCHIVE/$ASP/WHITEBA

##############################################################
# Atom Quest
##############################################################

mkdir -p $ARCHIVE/$PCW
java -jar ../java/atombasic/atombasic.jar ../magazines/PCW/QUEST.bas $ARCHIVE/$PCW/QUEST
java -jar ../java/atombasic/atombasic.jar ../magazines/PCW/MISDODG.bas $ARCHIVE/$PCW/MISDODG
java -jar ../java/atombasic/atombasic.jar ../magazines/PCW/BACKGAM.bas $ARCHIVE/$PCW/BACKGAM
java -jar ../java/atombasic/atombasic.jar ../magazines/PCW/GHOST.bas $ARCHIVE/$PCW/GHOST
java -jar ../java/atombasic/atombasic.jar ../magazines/PCW/TURBO.bas $ARCHIVE/$PCW/TURBO
java -jar ../java/atombasic/atombasic.jar ../magazines/PCW/CAKES.bas $ARCHIVE/$PCW/CAKES

##############################################################
# Books
##############################################################

pushd ../books
for SRC in `find . -name *.bas | cut -c3- | sort`
do
DST=../archive/$ARCHIVE/`dirname $SRC`/`basename $SRC .bas`
java -jar ../java/atombasic/atombasic.jar $SRC $DST
done
# Special Case the SPL Compiler to load at 8200
java -jar ../java/atombasic/atombasic.jar PPBA/COMPILER.bas  ../archive/$ARCHIVE/PPBA/COMPILER 8200
popd

##############################################################
# Other
##############################################################

mkdir -p $ARCHIVE/$OTHER
cp atms/spellen1/MOONLAN $ARCHIVE/$OTHER

java -jar ../java/atombasic/atombasic.jar ../magazines/TheAtom/RACER.bas $ARCHIVE/$OTHER/RACER

# A binary version was included instead, as there is a patch in issue 2
#java -jar ../java/atombasic/atombasic.jar ../magazines/TheAtom/BREAKBA.bas $ARCHIVE/$OTHER/BREAKBA 2900
#java -jar ../java/atombasic/atombasic.jar ../magazines/TheAtom/BREAKMC.bas $ARCHIVE/$OTHER/BREAKMC 2B00

for i in SHOW1 SHOW2 SHOW3 DISOLV3 DISOLV4 DISOLV5 DISOLV6 DISOLV7
do
    java -jar ../java/atombasic/atombasic.jar ../agdzips/$i.bas $ARCHIVE/AGD/$i 2900 ce86
done

##############################################################
# Magnus Olsson
##############################################################

mkdir -p $ARCHIVE/$MO

# Atomia Akorny
# This is now the version I ported to not use the extension ROM
# cp atms/gamebase/048/048 $ARCHIVE/$MO
# cp atms/gamebase/233/ATOMIAAK "$ARCHIVE/$MO/ATOMIA AK.DAT"

# Star Trek
cp atms/gamebase/157/157 $ARCHIVE/$MO
cp atms/gamebase/157S/157S $ARCHIVE/$MO

# Dragon
cp atms/gamebase/171/171 $ARCHIVE/$MO
cp atms/gamebase/171B/171B $ARCHIVE/$MO
cp atms/gamebase/DRAGONC/DRAGONC $ARCHIVE/$MO

# Diamonds
package "atms/Magnus2/DIAMONDS" "$ARCHIVE/$MO"

##############################################################
# Retro Software
##############################################################

package "atms/CHUCKIE/*" "$ARCHIVE/$RS/CHUCKIE"
package "atms/GALA/*"    "$ARCHIVE/$RS/GALA"
package "atms/HARRY/*"   "$ARCHIVE/$RS/HARRY"
package "atms/HYPERV/*"  "$ARCHIVE/$RS/HYPERV"
package "atms/MINER/*"   "$ARCHIVE/$RS/MINER"
package "atms/JUNGLE/*"  "$ARCHIVE/$RS/JUNGLE"
package "atms/REPTON/*"  "$ARCHIVE/$RS/REPTON"

package "atms/gamebase/229/*"  "$ARCHIVE/$RS/CASQUEST"
package "atms/gamebase/229-DATA/*" "$ARCHIVE/$RS/CASQUEST"

##############################################################
# Level9
##############################################################

mkdir -p $ARCHIVE/$L9
pushd ../level9
$BEEBASM -i VDUBLO.ASM
$BEEBASM -i VDUWLO.ASM
for SRC in `find *.ASM | grep -v OSEMUL | grep -v VDU`
do
DST=`basename $SRC .ASM`
$BEEBASM -i $SRC
# Each adventure has it's own subdirectory to keep the saved games seperate
mkdir ../archive/$ARCHIVE/$L9/$DST
mv $DST ../archive/$ARCHIVE/$L9/$DST
# Copy VDU drivers into each subdirectory
cp VDUBLO VDUWLO ../archive/$ARCHIVE/$L9/$DST
done
rm VDUBLO VDUWLO
popd

##############################################################
# QUILL
##############################################################

mkdir -p $ARCHIVE/$QUILL
pushd ../quill
# Compile the Quill interpreter
$BEEBASM -i QLUC32.ASM
$BEEBASM -i QLLC32.ASM
$BEEBASM -i QLUC40.ASM
$BEEBASM -i QLLC40.ASM
for SRC in `find [a-zA-Z]* -type d`
do
DST=`basename $SRC`
# Compile the quill adventure, justifying for both screen widths
mkdir ../archive/$ARCHIVE/$QUILL/$DST
java -jar ../java/atomquill/atomquill.jar $DST/DB ../archive/$ARCHIVE/$QUILL/$DST/DB32 32
java -jar ../java/atomquill/atomquill.jar $DST/DB ../archive/$ARCHIVE/$QUILL/$DST/DB40 40
# Copy Quill Interprter to each subdirectory
cp QLUC32 QLLC32 QLUC40 QLLC40 ../archive/$ARCHIVE/$QUILL/$DST
# Copy VDU2440 to each subdirectory
cp VDU2440 ../archive/$ARCHIVE/$QUILL/$DST
done
rm QLUC32 QLLC32 QLUC40 QLLC40
popd

##############################################################
# Acornsoft
##############################################################

package "atms/1_interactive_teaching/*" "$ARCHIVE/$AS/INTRO1"
package "atms/2_financial_planning/*" "$ARCHIVE/$AS/INTRO2"
package "atms/3_household/*" "$ARCHIVE/$AS/INTRO3"
package "atms/4_games/*" "$ARCHIVE/$AS/INTRO4"

package "atms/business/*" "$ARCHIVE/$AS/BUSINESS"
package "atms/introduction/DCF" "$ARCHIVE/$AS/BUSINESS"

package "atms/Acl1-13/SYNTH" "$ARCHIVE/$AS/SYNTH"
package "atms/Acl1-13/TOCCATA" "$ARCHIVE/$AS/SYNTH"
package "atms/Acl1-13/SEASIDE" "$ARCHIVE/$AS/SYNTH"
package "atms/Acl1-13/PICNIC" "$ARCHIVE/$AS/SYNTH"

package "atms/Acl1-15/LIFE" "$ARCHIVE/$AS/LIFE"
package "atms/Acl1-15/LIFEPA" "$ARCHIVE/$AS/LIFE"
package "atms/Acl1-15/LIFEPB" "$ARCHIVE/$AS/LIFE"
package "atms/Acl1-15/LIFEPD" "$ARCHIVE/$AS/LIFE"
package "atms/Acl1-15/LIFEPE" "$ARCHIVE/$AS/LIFE"

package "atms/Acl1-13/ADRBOOK" "$ARCHIVE/$AS/DIARY"
package "atms/Acl1-13/PLANNER" "$ARCHIVE/$AS/DIARY"

package "atms/acorn_database/*" "$ARCHIVE/$AS/DATABASE"

package "atms/acorn_utilitypack1/FASTCOS" "$ARCHIVE/$AS/UTILS1"
package "atms/Acl1-19/DISASAS" "$ARCHIVE/$AS/UTILS1"
package "atms/Acl1-19/RENUM" "$ARCHIVE/$AS/UTILS1"

package "atms/soft_vdu/*" "$ARCHIVE/$AS/SOFTVDU"

package "atms/acornsoft__peeko_computer/*" "$ARCHIVE/$AS/PEEKO"

package "atms/kant2/SIMULTAN" "$ARCHIVE/$AS/MATHS1"
package "atms/kant2/REGRESSI" "$ARCHIVE/$AS/MATHS1"
package "atms/kant2/PLOT" "$ARCHIVE/$AS/MATHS1"

package "atms/kant2/POLYNOM" "$ARCHIVE/$AS/MATHS2"
package "atms/kant2/RATIONAL" "$ARCHIVE/$AS/MATHS2"
package "atms/kant2/TRIGONOM" "$ARCHIVE/$AS/MATHS2"
package "atms/kant2/FOURIER" "$ARCHIVE/$AS/MATHS2"

package "atms/Steve/ASTEROID" "$ARCHIVE/$AS/GAMES01"
package "atms/Menno1/SUBHUNT" "$ARCHIVE/$AS/GAMES01"
package "atms/Steve/BREAKOUT" "$ARCHIVE/$AS/GAMES01"

package "atms/acornsoft__games_pack_2/*" "$ARCHIVE/$AS/GAMES02"

package "atms/c90_1_spellen/LANDER" "$ARCHIVE/$AS/GAMES03"
package "atms/c90_1_spellen/RATTRAP" "$ARCHIVE/$AS/GAMES03"
package "atms/c90_1_spellen/BLACKBOX" "$ARCHIVE/$AS/GAMES03"

package "atms/Games1/STARTREK" "$ARCHIVE/$AS/GAMES04"
package "atms/Games1/FOURROW" "$ARCHIVE/$AS/GAMES04"
package "atms/Games1/ATTACK" "$ARCHIVE/$AS/GAMES04"

package "atms/c90_1_spellen/WUMPUS" "$ARCHIVE/$AS/GAMES05"
package "atms/c90_1_spellen/REVERSI" "$ARCHIVE/$AS/GAMES05"
package "atms/c90_1_spellen/SACEINVA" "$ARCHIVE/$AS/GAMES05"
mv $ARCHIVE/$AS/GAMES05/SACEINVA $ARCHIVE/$AS/GAMES05/INVADERS

package "atms/c90_1_spellen/DODGEMS" "$ARCHIVE/$AS/GAMES06"
package "atms/c90_1_spellen/SIMON" "$ARCHIVE/$AS/GAMES06"
package "atms/c90_1_spellen/AMOEBA" "$ARCHIVE/$AS/GAMES06"

package "atms/c90_1_spellen/GREENTHI" "$ARCHIVE/$AS/GAMES07"
package "atms/c90_1_spellen/BALLISTI" "$ARCHIVE/$AS/GAMES07"
package "atms/c90_1_spellen/SNAKE" "$ARCHIVE/$AS/GAMES07"

package "atms/c90_1_spellen/STARGATE" "$ARCHIVE/$AS/GAMES08"
package "atms/c90_1_spellen/ROBOTS" "$ARCHIVE/$AS/GAMES08"
package "atms/c90_1_spellen/GOMOKU" "$ARCHIVE/$AS/GAMES08"

package "atms/c90_1_spellen/SNAPPER" "$ARCHIVE/$AS/GAMES09"
package "atms/c90_1_spellen/MINOTAUR" "$ARCHIVE/$AS/GAMES09"
package "atms/c90_1_spellen/BABIES" "$ARCHIVE/$AS/GAMES09"

package "atms/Acl2-33/MISSILE" "$ARCHIVE/$AS/GAMES11"
package "atms/Acl2-33/PART2" "$ARCHIVE/$AS/GAMES11"
package "atms/Acl1-11/SNOOKER" "$ARCHIVE/$AS/GAMES11"
package "atms/Acl1-11/DOMINO" "$ARCHIVE/$AS/GAMES11"

package "atms/Games5/LOADER" "$ARCHIVE/$AS/ADVENT"
package "atms/Games5/ADVENTUR" "$ARCHIVE/$AS/ADVENT"
package "atms/Games5/DUNGEON" "$ARCHIVE/$AS/ADVENT"
package "atms/Games5/HOUSE" "$ARCHIVE/$AS/ADVENT"
package "atms/Games5/INTERGAL" "$ARCHIVE/$AS/ADVENT"
package "atms/Adventur/SPH*" "$ARCHIVE/$AS/ADVENT"

package "atms/Games3/CHESS" "$ARCHIVE/$AS/CHESS"

package "atms/forth/*" "$ARCHIVE/$AS/FORTH"

package "atms/Applic1/LISP*" "$ARCHIVE/$AS/LISP"

package "atms/dd-18/PASCAL" "$ARCHIVE/$AS/PASCAL"

package "atms/Friso/ATOMCALC" "$ARCHIVE/$AS/ATOMCALC"

package "atms/Wordpack/ED64" "$ARCHIVE/$AS/WORDPACK"

package "atms/dd-21/PAIRS" "$ARCHIVE/$AS/WORDTUT"
package "atms/dd-21/PAIRSD" "$ARCHIVE/$AS/WORDTUT"
package "atms/dd-21/RELAT" "$ARCHIVE/$AS/WORDTUT"
package "atms/dd-21/RELATD" "$ARCHIVE/$AS/WORDTUT"
package "atms/dd-21/SENTENS" "$ARCHIVE/$AS/WORDTUT"
package "atms/dd-21/SENTD" "$ARCHIVE/$AS/WORDTUT"

##############################################################
# Bug-Byte
##############################################################

package "atms/Acl1-15/747" "$ARCHIVE/$BB"
# package "atms/Acl1-06/BREAKOU" "$ARCHIVE/$BB" # not bugbyte
# package "atms/Acl1-15/INVADBB" "$ARCHIVE/$BB" # manually fixed
# package "atms/Acl1-03/BACKGAM" "$ARCHIVE/$BB" # not sure this is bug byte, but could be
# package "atms/Acl1-21/BATSHIP" "$ARCHIVE/$BB" # this is actually a program called space battle that need FP Rom
package "atms/Acl2-19/BIORYTH" "$ARCHIVE/$BB"
#package "atms/bugbyte__chess_disk/*" "$ARCHIVE/$BB"
#mv $ARCHIVE/$BB/AJM "$ARCHIVE/$BB/--AJM"

# BB Chess now included in DAVE
# Was provided by Kees
#package "atms/Acl1-15/CHESSBB" "$ARCHIVE/$BB"
#package "atms/Acl1-15/PROG" "$ARCHIVE/$BB"
#package "atms/Acl1-15/212" "$ARCHIVE/$BB"
#mv $ARCHIVE/$BB/212 "$ARCHIVE/$BB/2. 12"
#package "atms/schaken_dammen/CHBB*" "$ARCHIVE/$BB"


package "atms/Acl1-15/FRUITBB" "$ARCHIVE/$BB"
package "atms/Acl1-15/GALAXBB" "$ARCHIVE/$BB"
package "atms/Acl1-11/GOLFBB" "$ARCHIVE/$BB"
# package "atms/Steve/LABYRINT" "$ARCHIVE/$BB" # not bugbyte
package "atms/Acl1-08/LASTRUN" "$ARCHIVE/$BB"
package "atms/Acl1-15/LUNARBB" "$ARCHIVE/$BB"
package "atms/Acl1-08/PINBALL" "$ARCHIVE/$BB"
package "atms/Games2/PONTOON" "$ARCHIVE/$BB"
# package "atms/Acl1-09/STRTREK" "$ARCHIVE/$BB" # not bugbyte
package "atms/Acl1-15/UFO" "$ARCHIVE/$BB"
package "atms/Acl1-11/WIGGEL" "$ARCHIVE/$BB"
package "atms/Acl1-08/RHINO" "$ARCHIVE/$BB"

##############################################################
# Micromania
##############################################################

package "atms/Acl1-10/CENTI" "$ARCHIVE/$MM"
package "atms/Acl1-11/OMEGA" "$ARCHIVE/$MM"
package "atms/Acl1-11/DATA" "$ARCHIVE/$MM"
package "atms/Acl1-18/DEFEND" "$ARCHIVE/$MM"
package "atms/Acl1-11/PUCKMAN" "$ARCHIVE/$MM"

##############################################################
# Timedata
##############################################################

package "atms/Acl1-14/HAMMUR" "$ARCHIVE/$TD"
package "atms/Acl1-14/OTHELLO" "$ARCHIVE/$TD"
package "atms/Acl1-14/SCRAMB" "$ARCHIVE/$TD"
package "atms/Leendert/HEXPAWN" "$ARCHIVE/$TD"

package "atms/Leendert/CUPBALL" "$ARCHIVE/$TD"
package "atms/Leendert/BREAKOUT" "$ARCHIVE/$TD"
package "atms/Leendert/SIMON2" "$ARCHIVE/$TD"
package "atms/Leendert/3DMAZE" "$ARCHIVE/$TD"

package "atms/spellen3/PINBALL" "$ARCHIVE/$TD"
package "atms/Leendert/SPACEWAR" "$ARCHIVE/$TD"
package "atms/Leendert/DRIVE" "$ARCHIVE/$TD"


##############################################################
# Program Power
##############################################################

package "atms/Acl1-15/ADV*" "$ARCHIVE/$PP"
package "atms/Leendert/3DASTERO" "$ARCHIVE/$PP"
package "atms/games8/ASTROBI" "$ARCHIVE/$PP"
package "atms/atomix_tape_7/AWARI" "$ARCHIVE/$PP"
#package "atms/program_power__chess/*" "$ARCHIVE/$PP/Chess"
package "atms/Acl1-15/CHESSPP" "$ARCHIVE/$PP"
package "atms/Acl1-15/112" "$ARCHIVE/$PP"
mv $ARCHIVE/$PP/112 $ARCHIVE/$PP/1.12
package "atms/Acl1-15/TEXT" "$ARCHIVE/$PP"
package "atms/Friso/CONSTELL" "$ARCHIVE/$PP"
package "atms/Friso/DEMONDUN" "$ARCHIVE/$PP"
package "atms/Acl1-03/ROME*" "$ARCHIVE/$PP"
#package "atms/dd-01/FIGHTER" "$ARCHIVE/$PP"
package "atms/Acl1-25/HYPERFI" "$ARCHIVE/$PP"
package "atms/Steve/INVADERF" "$ARCHIVE/$PP"
#package "atms/Games1/MARTIANS" "$ARCHIVE/$PP" # manually fixed
package "atms/Menno1/MOONPATR" "$ARCHIVE/$PP"
package "atms/dd-09/MUNCHY" "$ARCHIVE/$PP"
package "atms/Menno1/SHOOTOUT" "$ARCHIVE/$PP"
package "atms/spellen3/SNAKES" "$ARCHIVE/$PP"
package "atms/Menno1/STOCKCAR" "$ARCHIVE/$PP"
package "atms/Leendert/SWARM" "$ARCHIVE/$PP"
package "atms/Leendert/WARLORDS" "$ARCHIVE/$PP"

cp atms/gamebase/095/095 $ARCHIVE/$PP/BUSINESS
# cp atms/gamebase/178/178 $ARCHIVE/$PP/MURDER

package "atms/Acl1-13/ATOMSTO" "$ARCHIVE/$PP"
package "atms/Acl2-04/STDAT" "$ARCHIVE/$PP"

package "atms/Acl1-13/MICROB" "$ARCHIVE/$PP"
package "atms/spellen3/OTHELLO" "$ARCHIVE/$PP"
package "atms/spellen3/OTHINST" "$ARCHIVE/$PP"
package "atms/Acl1-14/SPBAT" "$ARCHIVE/$PP"
package "atms/Acl1-14/WAMPUS" "$ARCHIVE/$PP"

##############################################################
# A&F Software
##############################################################


package "atms/Leendert/CYLONATT" "$ARCHIVE/$AF"
package "atms/Leendert/EARLYWAR" "$ARCHIVE/$AF"
package "atms/Leendert/TORPEDOR" "$ARCHIVE/$AF"
package "atms/Acl1-11/PANIC" "$ARCHIVE/$AF"
package "atms/Acl1-11/PAINTER" "$ARCHIVE/$AF"
package "atms/Acl1-11/POLECAT" "$ARCHIVE/$AF"

# Now getting these from DAVE
# Origin was arcadian's tape, converted to ATM by me
#package "atms/Acl1-10/ZOD*" "$ARCHIVE/$AF"
#package "atms/Acl1-10/SATEL*" "$ARCHIVE/$AF"
#package "atms/Acl1-10/ADV*" "$ARCHIVE/$AF"
#package "atms/Acl1-09/ADV*" "$ARCHIVE/$AF"

# Acornoft
#_ADVENTURE.LOADER 2900 ce86 0225 167b6f169092400592cd1d014c5f5851 Adventur
#_ADVENTURE.MAIN 2800 3bf0 1400 e8c8ec24fe3139efe56ff36a9162ba50 Adventur
#_ADVENTURE 2800 3bf0 1400 e8c8ec24fe3139efe56ff36a9162ba50 Games5
#_ADVENTURE.MAIN 2800 3bf0 1400 e8c8ec24fe3139efe56ff36a9162ba50 ALLGAMES
#_ADVENT 2800 3bf0 14eb ca027d8e663414f6abb8a6e772180c39 Acl1-17

# Program Power
#_ADV DA 8200 8200 1600 ab8f502d13acc982d81963f88a6e6703 games1
#_ADV CO 2800 2800 1400 a201dc01069744e3da105f4df48bbe5a games1
#_ADVCODE 2800 2800 14eb 4f0761fcc3b20f42d083996663fe1092 Acl1-15
#_ADVDATA 8200 8200 16e9 bfd6a7e6b31b9d46584b9fcb99245477 Acl1-15

# Might be an adventure creator?
#_ADVSRC 8200 8200 0df2 c1785b59281c0e5738a2a171b779d031 Acl1-10
#_ADVCOMP 3300 3300 09f6 24eef99d8c9be7df5ece66c123195b4b Acl1-10
#_ADVPROG 8f00 8f00 09f6 cc5c2f029740abbc9cc6c20be9f6329c Acl1-10

# A&F Death Satellite (also SATELL and SATELDA)
#_ADV1D 8200 2880 16e9 31a9a66117efef34d75d4bb47b8a3554 Acl1-09
#_ADV1P 2800 289b 14eb c4e005d979b5d1fbda5da969efc11382 Acl1-09
#_ADV_AF 8000 821f 02fd e8d1c9c5fb47345ba05849281ed8278c Acl1-09

# LOST DURTCHMAN'S GOLD, needs P-Charme
#_ADV_LDG 2900 afaf 3dc2 4a8c20ed07940afe8bd1d825367304c4 Acl1-25

package "atms/Leendert/MINEFIEL" "$ARCHIVE/$AF"

##############################################################
# A&R Software
##############################################################

package "atms/Acl1-24/TRAP" "$ARCHIVE/$AR"

##############################################################
# Dave/Kees's Patches
##############################################################

cp -a dave/* $ARCHIVE
cp -a kees/* $ARCHIVE
cp -a roland/* $ARCHIVE
cp -a wim/* $ARCHIVE
