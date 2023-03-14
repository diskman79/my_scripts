#!/bin/sh

#Find all dep file and print them into one file
rm filelist.txt
find output/. -name "*.d" -exec cat {} + > filelist.txt

#Remove all obj file, and some other no need files
sed -i '/: /d;/.sbk/d;/.x /d;/.spr/d;/.smc/d;/.sdt/d;/.scf/d;/.ssy/d;/.sun/d;/.spd/d;/ \/p\//d;/\/stt/d;/ \/usr/d;/ \/nfs/d;/ ..\/dspi/d;/ ..\/shared/d;/ inc\//d;/ fwd\//d;/ fpc\//d;/ rfc\//d;/ sch\//d;/ rev\//d' filelist.txt

#Remove all " \" in line end
sed -i 's/ \\//g' filelist.txt

#Remove abs path
sed -i 's# ../../../../../fw_3g_ia# fw_3g_ia#g' filelist.txt
sed -i 's# ../../../../fw_3g_ia# fw_3g_ia#g' filelist.txt
sed -i 's# ../../../../../../../external# external#g' filelist.txt
sed -i 's# ../../../../external# external#g' filelist.txt
sed -i 's# ../../../../../../../modem# modem#g' filelist.txt
sed -i 's# ../../../../modem# modem#g' filelist.txt
sed -i 's# ../../../lte_phy# lte_phy#g' filelist.txt
sed -i 's# ../../../modem# modem#g' filelist.txt
sed -i 's#../../../modem#modem#g' filelist.txt
sed -i 's# ../../../../../../../radio_access_control# radio_access_control#g' filelist.txt
sed -i 's# ../../../../../radio_access_control# radio_access_control#g' filelist.txt
sed -i 's# ../../../../radio_access_control# radio_access_control#g' filelist.txt
sed -i 's# ../../../../radio_access_control# radio_access_control#g' filelist.txt
sed -i 's#'`pwd`'/##g' filelist.txt
sed -i 's/^[ \t]*//g' filelist.txt
sed -i 's/^[ \t]*$//g' filelist.txt
sed -i 's/ /\n/g' filelist.txt

#Change everything to folder name
#sed -i 's#/[^/]*$#\/*.*#' filelist.txt

#tar -jcf src.tar.bz2 -T filelist.txt

rm -rf full_sourcecode
mkdir full_sourcecode

# Copy files, this one is quite slow
#cat filelist.txt | xargs -I % cp --parents % full_sourcecode/

# Copy files, this one is quite fast
xargs --arg-file=filelist.txt cp --parents --target-directory=full_sourcecode/

if [ -e "/usr/bin/X11/7z" ];
then
  /usr/bin/X11/7z a -m0=lzma2 -mmt=20 -y full_src.7z full_sourcecode/
else
  7z a full_src.7z full_sourcecode/
fi

rm -rf full_sourcecode/



