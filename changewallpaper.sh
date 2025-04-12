#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <search_term>"
    exit 1
fi

match=$(find ~/wallpapers/ -type f -iname "*$1*.jpg" | head -n 1)

if [ -z "$match" ]; then
    echo "No matching .jpg file found for '$1' in ~/wallpapers"
    exit 2
fi

cp "$match" ~/wallpaper0.jpg

echo "good, now kill hyprpaper and run it again"
