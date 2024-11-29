#!/bin/sh

set -ex

article="https://www.urhh.sk/web/guest/zoznam-blokovanych-webov"

# Fetch the webpage and save it to a temporary file for inspection
wget -q ${article} --ca-certificate=ca_chains/disig.sk-r2i2-chain.pem -O /tmp/webpage.html

# Print the webpage content for debugging
cat /tmp/webpage.html

# Extract the CSV file URL and print it
file=$(perl -lne 'print $1 if /href="(.*?\.csv[^"]*)"/' /tmp/webpage.html)
echo "Detected CSV URL: ${file}"

# Attempt to download the CSV file
if ! wget -q "${file}" --ca-certificate=ca_chains/disig.sk-r2i2-chain.pem -O original/sk/urhh.sk.csv; then
    echo "Failed to download CSV file"
    exit 1
fi

# Process the CSV file
cat original/sk/urhh.sk.csv \
    | tail -n +5 \
    | awk -F";" '{print $3}' \
    | sed 's/ //g' \
    | awk NF \
> csv/sk/urhh.sk.csv

