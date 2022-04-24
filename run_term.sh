#!/bin/bash

[ -z "$TERMINAL" ] && echo "TERMINAL env var not set" && exit 1

theme_file="$1"

[ -z "$theme_file" ] && echo "filename is empty" && exit 1
[ ! -f "$theme_file" ] && echo "file not found" && exit 1

xrdb_dump="/tmp/xrdb-dump.Xresources"
xrdb -query > "$xrdb_dump"

source "$theme_file" &>/dev/null

theme_dump="/tmp/theme-dump.txt"
rm -f "$theme_dump"

{
    echo "! vim: ft=xdefaults"
    echo "! $PROFILE_NAME"
    echo "st.background:  $BACKGROUND_COLOR"
    echo "st.foreground:  $FOREGROUND_COLOR"
    echo "st.cursorColor: $CURSOR_COLOR"
    echo "! Black + DarkGrey"
    echo "st.color0:      $COLOR_01"
    echo "st.color8:      $COLOR_09"
    echo "! DarkRed + Red"
    echo "st.color1:      $COLOR_02"
    echo "st.color9:      $COLOR_10"
    echo "! DarkGreen + Green"
    echo "st.color2:      $COLOR_03"
    echo "st.color10:     $COLOR_11"
    echo "! DarkYellow + Yellow"
    echo "st.color3:      $COLOR_04"
    echo "st.color11:     $COLOR_12"
    echo "! DarkBlue + Blue"
    echo "st.color4:      $COLOR_05"
    echo "st.color12:     $COLOR_13"
    echo "! DarkMagenta + Magenta"
    echo "st.color5:      $COLOR_06"
    echo "st.color13:     $COLOR_14"
    echo "! DarkCyan + Cyan"
    echo "st.color6:      $COLOR_07"
    echo "st.color14:     $COLOR_15"
    echo "! LightGrey + White"
    echo "st.color7:      $COLOR_08"
    echo "st.color15:     $COLOR_16"
} > "$theme_dump"

echo "Xresources theme: $theme_dump"

xrdb -merge "$theme_dump"
$TERMINAL &>/dev/null

xrdb -load "$xrdb_dump"
