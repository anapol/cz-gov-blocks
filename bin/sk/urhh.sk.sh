#!/bin/sh

set -ex

article="https://www.urhh.sk/web/guest/zoznam-blokovanych-webov"

file=`wget -q ${article} --ca-certificate=ca_chains/disig.sk-r2i2-chain.pem -O - | perl -lne 'print $1 if /href="(.*?\.csv[^"]*)"/'`

wget -q "${file}" --ca-certificate=ca_chains/disig.sk-r2i2-chain.pem -O original/sk/urhh.sk.csv

cat original/sk/urhh.sk.csv \
    | tail -n +5 \
    | awk -F";" '{print $3}' \
    | sed 's/ //g' \
    | awk NF \
> csv/sk/urhh.sk.csv

