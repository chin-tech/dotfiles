#!/usr/bin/env bash


in_file=$1

curr_main="SF Pro Text"
curr_mono="SF Mono"

main_font="Hack Nerd Font"
mono_font="RobotoMono Nerd Font"


sed -i "s/${curr_main}/${main_font}/g" $in_file
sed -i "s/${curr_mono}/${mono_font}/g" $in_file
sed -i 's/align(right)\[#counter(page).display(pagenumbering)\]/if pagenumbering != none {align(right)\[#counter(page).display(pagenumbering)\]}/g' $in_file
# To Delete
sed -i 's/\"LXGW.*GB\",//g' $in_file
sed -i 's/\"Apple Color Emoji",//g' $in_file
sed -i '/emmoji_fonts=/s/\")/",)/g' $in_file




