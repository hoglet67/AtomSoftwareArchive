#!/bin/bash

# Make a list of unique screens
md5sum ../archive/kees/AGD/*/*SCR | sort | uniq -u -w33 | cut -d/ -f5-6 | sort > list

rm -f  list.atommc
rm -f  list.econet

line=1000
for path in `cat list`
do
    dir=`echo $path | cut -d/ -f1`
    file=`echo $path | cut -d/ -f2`

    # AtoMMC:
    # 1000$P="ADAGGER/DAGSCR";R.
    echo "  ${line}\$P=\"${dir}/${file}\";R." >> list.atommc

    # Econet
    # 1000$P="3.9.7/DAGSCR";R.
    dir=`echo $path | cut -d/ -f1`
    num=`grep ,AGD/${dir}, ../catalog/AtomSoftwareCatalog.csv | cut -d, -f1`
    d1=`echo "obase=16; $num" | bc | cut -c1`
    d2=`echo "obase=16; $num" | bc | cut -c2`
    d3=`echo "obase=16; $num" | bc | cut -c3`
    echo "  ${line}\$P=\"${d1}.${d2}.${d3}/${file}\";R." >> list.econet

    # next line
    line=$((line + 1))
done

rm -f list
