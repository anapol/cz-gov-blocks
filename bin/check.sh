#!/bin/sh

set -x

out=`egrep -v '^[a-zA-Z0-9\.-]+$' csv/*.csv csv/sk/*.csv`

set -ex

if [ -z "$out" ]; then
    echo "No errors found"
    exit 0
fi

echo "$out"
echo "Errors found, exiting..."
exit 1

