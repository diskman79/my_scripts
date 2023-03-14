#!/bin/bash

rm -rf output
rm -f /local/${USER}/dep_sources/filelist.txt
bee init -b rel12/development
bee sync -j16
cd utils/ubs
gmake -j4 PROJECT=XMM7560 SYSTARGET=XMM7560_REV_3.0_NAND STT=YES
if [ -e ../../output/XMM7560/XMM7560_REV_3.0_NAND/modem/XMM7560_NAND.fls ]
then
    cp ~/linux_scripts/xmm7560_dep.sh ../../output/XMM7560/XMM7560_REV_3.0_NAND/dep.sh
    cd ../../output/XMM7560/XMM7560_REV_3.0_NAND
    dep.sh -f modem/dep -t /local/${USER}/dep_sources/ -z sources-modem.zip
    dep.sh -f rpcu -t /local/${USER}/dep_sources/ -z sources-rpcu.zip
    dep.sh -f dpc -t /local/${USER}/dep_sources/ -z sources-dpc.zip
    dep.sh -f bootsystem -t /local/${USER}/dep_sources/ -z sources-bootsystem.zip
    dep.sh -f fw4g -t /local/${USER}/dep_sources/ -z sources-fw4g.zip
    dep.sh -f fw3g -t /local/${USER}/dep_sources/ -z sources-fw3g.zip
    cd /local/${USER}/dep_sources
    7z x -y sources-modem.zip      -osources-modem
    7z x -y sources-rpcu.zip       -osources-rpcu
    7z x -y sources-dpc.zip        -osources-dpc
    7z x -y sources-bootsystem.zip -osources-bootsystem
    7z x -y sources-fw4g.zip       -osources-fw4g
    7z x -y sources-fw3g.zip       -osources-fw3g
else
    error_filename="/local/${USER}/dep_sources/Missing FLS file $(date +%s).txt"
    echo $error_filename
    touch "$error_filename"
fi
