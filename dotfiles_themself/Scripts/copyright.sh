#!/bin/bash
#
# Copyright banner with ASCII art
# Single-purpose script - displays system info with decorative art
#

# ===== CONFIGURATION =====
# System information
CURRENT_YEAR=$(date +%Y)
DISTRO_INFO=$(uname -srm)

if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO_NAME="$PRETTY_NAME"
else
    DISTRO_NAME=$(uname -s)
fi

# Text content
COPYRIGHT_LINES=(
    "Arch Linux [Version $DISTRO_INFO]"
    "(c) $CURRENT_YEAR $DISTRO_NAME Corporation. All rights reserved."
)

# ASCII art (right side)
ASCII_ART=(
    ' ╱|、'
    '(˚ˎ 。7  '
    ' |、˜〵'
    ' じしˍ,)ノ'
)

# ===== CALCULATIONS =====
# Find longest copyright line
max_copyright_len=0
for line in "${COPYRIGHT_LINES[@]}"; do
    line_len=${#line}
    (( line_len > max_copyright_len )) && max_copyright_len=$line_len
done

# ===== DISPLAY =====
# Line 1: Copyright line 1 + ASCII art line 1
copyright_len=${#COPYRIGHT_LINES[0]}
padding=$(( max_copyright_len - copyright_len ))
printf "%s%*s %s\n" "${COPYRIGHT_LINES[0]}" $padding '' "${ASCII_ART[0]}"

# Line 2: Copyright line 2 + ASCII art line 2
printf "%s %s\n" "${COPYRIGHT_LINES[1]}" "${ASCII_ART[1]}"

# Lines 3-4: Padding + remaining ASCII art
printf "%*s %s\n" $max_copyright_len '' "${ASCII_ART[2]}"
printf "%*s %s\n" $max_copyright_len '' "${ASCII_ART[3]}"
