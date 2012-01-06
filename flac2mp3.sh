#!/bin/sh

test -e mp3 || mkdir mp3

echo Processing:

for I in *.flac; do
        echo "$I"
        flac -d --silent --stdout "$I" | lame --silent -V2 --vbr-new - mp3/"$I"
        id3cp -2 "$I" mp3/"$I" >/dev/null
        base=`basename "$I" .flac`
        mv mp3/"$I" mp3/"$base".mp3
done