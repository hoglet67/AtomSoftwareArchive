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

rm -rf $ARCHIVE
mkdir -p $ARCHIVE

##############################################################
# Other
##############################################################

mkdir -p $ARCHIVE/$OTHER

##############################################################
# Magnus Olsson
##############################################################

mkdir -p $ARCHIVE/$MO

# Atomia Akorny
# This is now the version I ported to not use the extension ROM
# cp atms/gamebase/048/048 $ARCHIVE/$MO
# cp atms/gamebase/233/ATOMIAAK "$ARCHIVE/$MO/ATOMIA AK.DAT"

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

package "atms/gamebase/229/*"  "$ARCHIVE/$RS/CASQUEST"
package "atms/gamebase/229-DATA/*" "$ARCHIVE/$RS/CASQUEST"

##############################################################
# Level9
##############################################################

mkdir -p $ARCHIVE/$L9
pushd $ARCHIVE/$L9
../../../../BeebASM/beebasm/beebasm -i ../../../level9/COLOSSAL.ASM
../../../../BeebASM/beebasm/beebasm -i ../../../level9/SNOWBALL.ASM
../../../../BeebASM/beebasm/beebasm -i ../../../level9/VDUBLO.ASM
../../../../BeebASM/beebasm/beebasm -i ../../../level9/VDUWLO.ASM
popd

##############################################################
# Acornsoft
##############################################################

package "atms/1_interactive_teaching/*" "$ARCHIVE/$AS/Intro1"
package "atms/2_financial_planning/*" "$ARCHIVE/$AS/Intro2" 
package "atms/3_household/*" "$ARCHIVE/$AS/Intro3" 
package "atms/4_games/*" "$ARCHIVE/$AS/Intro4" 

package "atms/business/*" "$ARCHIVE/$AS/Business" 
package "atms/introduction/DCF" "$ARCHIVE/$AS/Business" 

package "atms/Acl1-13/SYNTH" "$ARCHIVE/$AS/Synth"
package "atms/Acl1-13/TOCCATA" "$ARCHIVE/$AS/Synth"
package "atms/Acl1-13/SEASIDE" "$ARCHIVE/$AS/Synth"
package "atms/Acl1-13/PICNIC" "$ARCHIVE/$AS/Synth"

package "atms/Acl1-15/LIFE" "$ARCHIVE/$AS/Life"
package "atms/Acl1-15/LIFEPA" "$ARCHIVE/$AS/Life"
package "atms/Acl1-15/LIFEPB" "$ARCHIVE/$AS/Life"
package "atms/Acl1-15/LIFEPD" "$ARCHIVE/$AS/Life"
package "atms/Acl1-15/LIFEPE" "$ARCHIVE/$AS/Life"

package "atms/Acl1-13/ADRBOOK" "$ARCHIVE/$AS/Diary"
package "atms/Acl1-13/PLANNER" "$ARCHIVE/$AS/Diary"

package "atms/acorn_database/*" "$ARCHIVE/$AS/Database"

package "atms/acorn_utilitypack1/FASTCOS" "$ARCHIVE/$AS/Utils1"
package "atms/Acl1-19/DISASAS" "$ARCHIVE/$AS/Utils1"
package "atms/Acl1-19/RENUM" "$ARCHIVE/$AS/Utils1"

package "atms/soft_vdu/*" "$ARCHIVE/$AS/SoftVDU"

package "atms/acornsoft__peeko_computer/*" "$ARCHIVE/$AS/Peeko"

package "atms/kant2/SIMULTAN" "$ARCHIVE/$AS/Maths1"
package "atms/kant2/REGRESSI" "$ARCHIVE/$AS/Maths1"
package "atms/kant2/PLOT" "$ARCHIVE/$AS/Maths1"

package "atms/kant2/POLYNOM" "$ARCHIVE/$AS/Maths2"
package "atms/kant2/RATIONAL" "$ARCHIVE/$AS/Maths2"
package "atms/kant2/TRIGONOM" "$ARCHIVE/$AS/Maths2"
package "atms/kant2/FOURIER" "$ARCHIVE/$AS/Maths2"

package "atms/Steve/ASTEROID" "$ARCHIVE/$AS/Games01"
package "atms/Menno1/SUBHUNT" "$ARCHIVE/$AS/Games01"
package "atms/Steve/BREAKOUT" "$ARCHIVE/$AS/Games01"

package "atms/acornsoft__games_pack_2/*" "$ARCHIVE/$AS/Games02"

package "atms/c90_1_spellen/LANDER" "$ARCHIVE/$AS/Games03"
package "atms/c90_1_spellen/RATTRAP" "$ARCHIVE/$AS/Games03"
package "atms/c90_1_spellen/BLACKBOX" "$ARCHIVE/$AS/Games03"

package "atms/Games1/STARTREK" "$ARCHIVE/$AS/Games04"
package "atms/Games1/FOURROW" "$ARCHIVE/$AS/Games04"
package "atms/Games1/ATTACK" "$ARCHIVE/$AS/Games04"

package "atms/c90_1_spellen/WUMPUS" "$ARCHIVE/$AS/Games05"
package "atms/c90_1_spellen/REVERSI" "$ARCHIVE/$AS/Games05"
package "atms/c90_1_spellen/SACEINVA" "$ARCHIVE/$AS/Games05"
mv $ARCHIVE/$AS/Games05/SACEINVA $ARCHIVE/$AS/Games05/INVADERS

package "atms/c90_1_spellen/DODGEMS" "$ARCHIVE/$AS/Games06"
package "atms/c90_1_spellen/SIMON" "$ARCHIVE/$AS/Games06"
package "atms/c90_1_spellen/AMOEBA" "$ARCHIVE/$AS/Games06"

package "atms/c90_1_spellen/GREENTHI" "$ARCHIVE/$AS/Games07"
package "atms/c90_1_spellen/BALLISTI" "$ARCHIVE/$AS/Games07"
package "atms/c90_1_spellen/SNAKE" "$ARCHIVE/$AS/Games07"

package "atms/c90_1_spellen/STARGATE" "$ARCHIVE/$AS/Games08"
package "atms/c90_1_spellen/ROBOTS" "$ARCHIVE/$AS/Games08"
package "atms/c90_1_spellen/GOMOKU" "$ARCHIVE/$AS/Games08"

package "atms/c90_1_spellen/SNAPPER" "$ARCHIVE/$AS/Games09"
package "atms/c90_1_spellen/MINOTAUR" "$ARCHIVE/$AS/Games09"
package "atms/c90_1_spellen/BABIES" "$ARCHIVE/$AS/Games09"

package "atms/Acl2-33/MISSILE" "$ARCHIVE/$AS/Games11"
package "atms/Acl2-33/PART2" "$ARCHIVE/$AS/Games11"
package "atms/Acl1-11/SNOOKER" "$ARCHIVE/$AS/Games11"
package "atms/Acl1-11/DOMINO" "$ARCHIVE/$AS/Games11"

package "atms/Games5/LOADER" "$ARCHIVE/$AS/Advent"
package "atms/Games5/ADVENTUR" "$ARCHIVE/$AS/Advent"
package "atms/Games5/DUNGEON" "$ARCHIVE/$AS/Advent"
package "atms/Games5/HOUSE" "$ARCHIVE/$AS/Advent"
package "atms/Games5/INTERGAL" "$ARCHIVE/$AS/Advent"
package "atms/Adventur/SPH*" "$ARCHIVE/$AS/Advent"

package "atms/Games3/CHESS" "$ARCHIVE/$AS/Chess"

package "atms/forth/*" "$ARCHIVE/$AS/Forth"

package "atms/Applic1/LISP*" "$ARCHIVE/$AS/Lisp"

package "atms/dd-18/PASCAL" "$ARCHIVE/$AS/Pascal"

package "atms/Friso/ATOMCALC" "$ARCHIVE/$AS/AtomCalc"

package "atms/Wordpack/ED64" "$ARCHIVE/$AS/Wordpack"

package "atms/dd-21/PAIRS" "$ARCHIVE/$AS/Wordtut"
package "atms/dd-21/PAIRSD" "$ARCHIVE/$AS/Wordtut"
package "atms/dd-21/RELAT" "$ARCHIVE/$AS/Wordtut"
package "atms/dd-21/RELATD" "$ARCHIVE/$AS/Wordtut"
package "atms/dd-21/SENTENS" "$ARCHIVE/$AS/Wordtut"
package "atms/dd-21/SENTD" "$ARCHIVE/$AS/Wordtut"

##############################################################
# Bug-Byte
##############################################################

package "atms/Acl1-15/747" "$ARCHIVE/$BB"
# package "atms/Acl1-06/BREAKOU" "$ARCHIVE/$BB" # not bugbyte
package "atms/Acl1-15/INVADBB" "$ARCHIVE/$BB"
package "atms/Acl1-03/BACKGAM" "$ARCHIVE/$BB" # not sure this is bug byte, but could be
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
package "atms/games7/AIRATTA" "$ARCHIVE/$PP"
package "atms/games7/AIRDATA" "$ARCHIVE/$PP"
mv $ARCHIVE/$PP/AIRDATA $ARCHIVE/$PP/DATA
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
package "atms/dd-01/FIGHTER" "$ARCHIVE/$PP"
package "atms/Acl1-25/HYPERFI" "$ARCHIVE/$PP"
package "atms/Steve/INVADERF" "$ARCHIVE/$PP"
package "atms/Games1/MARTIANS" "$ARCHIVE/$PP"
package "atms/Menno1/MOONPATR" "$ARCHIVE/$PP"
package "atms/dd-09/MUNCHY" "$ARCHIVE/$PP"
package "atms/Menno1/SHOOTOUT" "$ARCHIVE/$PP"
package "atms/spellen3/SNAKES" "$ARCHIVE/$PP"
package "atms/Menno1/STOCKCAR" "$ARCHIVE/$PP"
package "atms/Leendert/SWARM" "$ARCHIVE/$PP"
package "atms/Leendert/WARLORDS" "$ARCHIVE/$PP"

cp atms/gamebase/095/095 $ARCHIVE/$PP/BUSINESS
cp atms/gamebase/178/178 $ARCHIVE/$PP/MURDER

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

##############################################################
# Build the menu
##############################################################
pushd ../menu
./build.sh
popd
pushd $ARCHIVE
unzip ../../menu/MNU.zip
popd

##############################################################
# Zip up the archive
##############################################################

pushd $ARCHIVE
zip -qr ../$ARCHIVE.zip .
popd
mv $ARCHIVE.zip ~

##############################################################
# Deploy to Atomulator for testing
##############################################################

pushd $ARCHIVE
cp -a * ../../../Atomulator/mmc
popd

