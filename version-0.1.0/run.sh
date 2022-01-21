#!/bin/bash
#
# convert anasum.root file twice
# for full enclosure and pointlike
# analysis
# 
# example:
#
# /evndisp/run.sh 64080.anasum.root
#
# output:
# ./data/pointlike/64080.fits.gz
# ./data/fullenclosure/64080.fits.ggz


if [[ $# < 2 ]]; then
    echo "./run.sh <anasum file> <effective area file>"
    exit
fi

source /workdir/root/bin/thisroot.sh

mkdir -p /data/pointlike/
mkdir -p /data/fullenclosure/

if [[ ! -e "/data/${1}" ]]; then
    echo "Data file not found: ${1}"
    exit
fi
if [[ ! -e "/data/${2}" ]]; then
    echo "Effective area file not found: ${2}"
    exit
fi

FITSF=$(basename ${1} .anasum.root)

rm -f /data/pointlike/${FITSF}.v2dl3.log /data/fullenclosure/${FITSF}.v2dl3.log

v2dl3 -f /data/${1} /data/${2} /data/pointlike/${FITSF}.fits.gz 2>&1 > /data/pointlike/${FITSF}.v2dl3.log
v2dl3 --full-enclosure  -f /data/${1} /data/${2} /data/fullenclosure/${FITSF}.fits.gz 2>&1 > /data/fullenclosure/${FITSF}.v2dl3.log

