#!/bin/bash

adjust_bright() {
    input=$1
    max_brightness=$(cat /sys/class/backlight/*/max_brightness)
    scaled_brightness=$(awk "BEGIN {printf \"%.0f\", $input * $max_brightness}")
    echo $scaled_brightness | sudo tee /sys/class/backlight/*/brightness
    echo $scaled_brightness"/"$max_brightness
}

adjust_bright $1
#xrandr --output eDP-1 --brightness "$1"
