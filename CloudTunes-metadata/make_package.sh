#!/bin/bash

if [ \( -z "$1" \) -o \( "$1" != "CloudTunes-force" -a "$1" != "CloudTunes-database" \) ]
then
    echo "Usage: $0 CloudTunes-force | CloudTunes-database"
    exit 1
fi

archive_dir=$1
archive_name=$archive_dir.zip
cwd=$( dirname "${BASH_SOURCE[0]}" )

cd $cwd
echo "Archiving $archive_dir to $archive_name"
rm -f $archive_name
cd $archive_dir
zip -r ../$archive_name .

