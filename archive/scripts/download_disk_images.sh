
for i in dd-01 \
dd-02 \
dd-03 \
dd-04 \
dd-05 \
dd-06 \
dd-07 \
dd-08 \
dd-09 \
dd-10 \
dd-11 \
dd-12 \
dd-13 \
dd-14 \
dd-15 \
dd-16 \
dd-17 \
dd-18 \
dd-19 \
dd-20 \
dd-21 \
dd-22 \
dd-23 \
dd-24 \
dd-25 \
dd-28 \
dd-29 \
dd-30 \
dd-31 \
dd-32 \
dd-33 \
dd-34 \
dd-35 \
dd-36 \
dd-37 \
dd-38 \
dd-39 \
dd-40 \
dd-41 \
dd-42 \
dd-43 \
dd-44 \
dd-45 \
dd-46 \
dd-47 \
dd-48 \
dd-49 \
dd-50 \
dd-51 \
dd-52
do

echo $i


 wget -O /tmp/listing "http://www.acornatom.nl/atomarch/$i"

  mkdir -p kees/$i

  for j in `cat /tmp/listing  | tr " " "\n" | grep href | cut -d\" -f2 | grep -v "^[?/]"`
  do
  wget -O "kees/$i/$j.atom1" "http://www.acornatom.nl/atomarch/$i/$j"
  done

done

exit














Acl1-01 \
Acl1-02 \
Acl1-03 \
Acl1-04 \
Acl1-05 \
Acl1-06 \
Acl1-07 \
Acl1-08 \
Acl1-09 \
Acl1-10 \
Acl1-11 \
Acl1-12 \
Acl1-13 \
Acl1-14 \
Acl1-15 \
Acl1-16 \
Acl1-17 \
Acl1-18 \
Acl1-19 \
Acl1-20 \
Acl1-21 \
Acl1-22 \
Acl1-23 \
Acl1-24 \
Acl1-25 \
Acl1-26 \
Acl1-27 \
Acl1-28 \
Acl1-29 \
Acl1-30 \
Acl1-31 \
Acl1-32 \
Acl2-01 \
Acl2-02 \
Acl2-03 \
Acl2-04 \
Acl2-05 \
Acl2-06 \
Acl2-07 \
Acl2-08 \
Acl2-09 \
Acl2-10 \
Acl2-11 \
Acl2-12 \
Acl2-13 \
Acl2-14 \
Acl2-15 \
Acl2-16 \
Acl2-17 \
Acl2-18 \
Acl2-19 \
Acl2-20 \
Acl2-21 \
Acl2-22 \
Acl2-23 \
Acl2-24 \
Acl2-25 \
Acl2-26 \
Acl2-27 \
Acl2-28 \
Acl2-29 \
Acl2-30 \
Acl2-31 \
Acl2-32 \
Acl2-33




An88-01 \
An88-02 \
An88-03 \
An88-04 \
An88-05 \
An88-06 \
An88-07 \
An88-08 \
An88-09 \
An88-10 \
An88-11 \
An88-12 \
An88-13 \
An88-14 \
An89-01 \
An89-02 \
An89-03 \
An89-04 \
An89-05 \
An89-06 \
An89-07 \
An89-08 \
An90-01 \
An90-02 \
An90-03 \
An90-04 \
An90-05 \
An90-06 \
An91-01 \
An91-02 \
An91-03 \
An91-04 \
An91-05 \
An92-01 \
An92-02 \
An92-03 \
An92-04 \
An92-05 \
An92-06 \
An93-01 \
An93-02 \
An93-03 \
An93-04 \
An93-05 \
An93-06 \
Atominpc.108 \
Atominpc.108/ATOM \
Atominpc.108/ATOM/FONT \
Atominpc.108/ATOM/ROMSRC \
Atominpc.108/ATOM/SHELL \
Atominpc.108/ATOM/SYSTEM \
Atominpc.108/EPROM \
Atominpc.215 \
Atominpc.215/ATOM \
Atominpc.215/ATOM/HELP \
Atominpc.215/ATOM/SOURCE \
Atominpc.215/ATOM/SYSTEM \
Atominpc.215/EPROM \
Atominpc.215/MASM4 \
Atominpc.220 \
Atominpc.220/ATOM \
Atominpc.220/ATOM/HELP \
Atominpc.220/ATOM/SOURCE \
Atominpc.220/ATOM/SYSTEM \
Atominpc.220/EPROM \
Atominpc.220/MASM4 \
Atominpc.310 \
Atominpc.310/ATOM \
Atominpc.310/ATOM/FONT \
Atominpc.310/EPROM \
Atominpc.310/HERCUTIL \
Atominpc.400 \
Atominpc.400/ATOM \
Atominpc.400/ATOM/APPS \
Atominpc.400/ATOM/FONT \
Atominpc.400/ATOM/HELP \
Atominpc.400/ATOM/SYSTEM \
Atominpc.400/INSTALL \
Atominpc.430 \
Pc2000-1		 \
Pc2000-2		 \
Pc2000-3 \
Pc2000-3/Bbcexpl \
Pc2000-3/Games \
Pc2000-3/Ice16f84 \
PC2002 \
Pc94-01 \
Pc94-02 \
Pc95-1/COMPRESS \
Pc95-1/WINATOM \
Pc95-2 \
Pc95-3 \
Pc96-1 \
Pc96-1/ATOMX87 \
Pc96-1/ATOMXMS \
Pc96-1/TRUECPU \
Pc96-1/ZOEK5 \
Pc96-2 \
Pc96-2/ELECTRON \
Pc96-2/EPOSKLOK \
Pc96-2/LETTERS \
Pc96-3 \
Pc96-3/ATOMCOS \
Pc96-3/ATOMCOS/DEMOS \
Pc96-3/ATOMCOS/SOURCE \
Pc96-3/ATOMDOS \
Pc96-3/EPROMMER \
Pc96-3/GUIDOGAL \
Pc96-3/HEXEDIT \
Pc96-3/HEXEDIT/SOURCE \
Pc96-3/TAPEONTW \
Pc97-1 \
Pc97-1/CASINDEX \
Pc97-1/EMUDOS \
Pc97-1/EMULINUX \
Pc97-1/GDOS \
Pc97-1/UTILROM \
Pc97-1/ZOEK \
Pc97-2/4OP1RIJ \
Pc97-2/AICDOS \
Pc97-2/MEMORY \
Pc97-2/Rexx \
Pc97-2/Rexx/RXIOPL \
Pc97-2/Rexx/RXMATHFN \
Pc97-2/Rexx/VREXX2 \
Pc97-3 \
Pc97-4 \
Pc98-1/Atom132 \
Pc98-1/AW-UTILS \
Pc98-1/BBCBASIC \
Pc98-1/Debugger/ATOM \
Pc98-1/Debugger/BBC \
Pc98-1/Debugger/SOURCE \
Pc98-1/DIVERSEN \
Pc98-1/FPX87 \
Pc98-1/ZOEK97 \
Pc98-2/Apc_spel/GOKKAST1 \
Pc98-2/Apc_spel/PUZZEL \
Pc98-2/Apc_spel/SOKATOM \
Pc98-2/DEBUG210 \
Pc98-2/DEBUG210/SOURCE \
Pc98-2/WINTOOLS \
Pc99-1/ATOM423 \
Pc99-1/AWZOEK \
Pc99-1/DISK \
Pc99-1/FPU2 \
Pc99-1/SPREDIT2 \
Pc99-2/ATOM133 \
Pc99-2/IMAGES \
Pc99-2/KNIPCUR \
Pc99-2/REMATOM \
Pc99-2/SOFTBBC \
Pc99-2/SOFTBBC/DISK \
 