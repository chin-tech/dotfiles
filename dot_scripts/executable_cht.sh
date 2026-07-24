#!/bin/bash

chosen=$(cat ~/.scripts/langs ~/.scripts/core | fzf)
read -p "Query: " query 
q=$(printf $query | tr ' ' '+')

if rg -q "^$chosen" ~/.scripts/langs; then
	search="cht.sh/$chosen/$q"
else 
	search="cht.sh/$chosen~$q"
fi
echo $search

tmux neww bash -c "curl $search| less"
