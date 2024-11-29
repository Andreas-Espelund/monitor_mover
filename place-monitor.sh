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

# Extract screen information
screen_info=$(displayplacer list)

# Extract screen IDs and types
screen_ids=($(echo "$screen_info" | grep "Persistent screen id" | awk '{print $4}'))
screen_types=($(echo "$screen_info" | grep "Type" | awk '{print $2}'))

# Initialize indices
main_display_idx=0
external_display_idx=0

# Determine which is the main and which is the external display
for i in "${!screen_ids[@]}"; do
  if [[ "${screen_types[$i]}" == *"MacBook"* ]]; then
    main_display_idx=$i
  else
    external_display_idx=$i
  fi
done

# Extract modes and resolutions
modes_and_resolutions=($(echo "$screen_info" | grep "current mode" | sed -n 's/.*mode \([0-9]*\): res:\([0-9]*x[0-9]*\).*/\1 \2/p'))



# Assign display modes and resolutions based on determined main and external display
main_display_mode=${modes_and_resolutions[main_display_idx*2]}
main_display_resolution=${modes_and_resolutions[main_display_idx*2+1]}

external_display_mode=${modes_and_resolutions[external_display_idx*2]}
external_display_resolution=${modes_and_resolutions[external_display_idx*2+1]}

external_display_id=${screen_ids[$external_display_idx]}
main_display_id=${screen_ids[$main_display_idx]}

# echo "Main display ID: $main_display_id"
# echo "Main display mode: $main_display_mode"
# echo "Main display resolution: $main_display_resolution"

# echo "External display ID: $external_display_id"
# echo "External display type: $external_display_type"
# echo "External display mode: $external_display_mode"
# echo "External display resolution: $external_display_resolution"

# Check if a position argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 {l|tl|t|tr|r|br|b|bl}"
    echo "l: left, tl: top-left, t: top, tr: top-right, r: right, br: bottom-right, b: bottom, bl: bottom-left"
    exit 1
fi

# Set origin based on the argument
IFS='x' read width height <<< "$main_display_resolution"

# Manually adjusted offsets
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
