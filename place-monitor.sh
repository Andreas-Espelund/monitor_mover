#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Move monitor
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖥️
# @raycast.argument1 { "type": "text", "placeholder": "Position: l, tl, t, tr, r, br, b, bl" }

# Documentation:
# @raycast.description Place the external monitor relative to the main screen
# @raycast.author andreas_espelund
# @raycast.authorURL https://raycast.com/andreas_espelund

# Extract screen IDs
screen_ids=($(displayplacer list | grep "Persistent screen id" | awk '{print $4}'))

# Extract modes and resolutions
modes_and_resolutions=($(displayplacer list | grep "current mode" | sed -n 's/.*mode \([0-9]*\): res:\([0-9]*x[0-9]*\).*/\1 \2/p'))

# Assign names to displays
main_display_id=${screen_ids[0]}
main_display_mode=${modes_and_resolutions[0]}
main_display_resolution=${modes_and_resolutions[1]}

external_display_id=${screen_ids[1]}
external_display_mode=${modes_and_resolutions[2]}
external_display_resolution=${modes_and_resolutions[3]}


# Check if a position argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 {l|tl|t|tr|r|br|b|bl}"
    echo "l: left, tl: top-left, t: top, tr: top-right, r: right, br: bottom-right, b: bottom, bl: bottom-left"
    exit 1
fi

# Set origin based on the argument
IFS='x' read width height <<< "$main_display_resolution"

# Manualy adjusted offsets
w_offset=120
h_offset=50

width=$((width + w_offset))
height=$((height + h_offset))

origin=""

# Calculate the origin based on the argument
case "$1" in
    l) origin="(-$width,$h_offset)" ;;
    tl) origin="(-$width,-$height)" ;;
    t) origin="(-$h_offset,-$height)" ;;
    tr) origin="($width,-$height)" ;;
    r) origin="($width,$h_offset)" ;;
    br) origin="($width,$height)";;
    b) origin="(-$h_offset,$height)";;
    bl) origin="(-$width,$height)";;
    *)
        echo "Invalid option. Use one of the following: l|tl|t|tr|r|br|b|bl"
        exit 1
        ;;
esac

# Move the external display
displayplacer "id:$external_display_id origin:$origin mode:$external_display_mode"
