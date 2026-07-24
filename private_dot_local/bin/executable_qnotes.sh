note_path="$MY_PENTEST_NOTES"
input_file=$(find "$note_path" -type f | fzf --preview "bat --style numbers,changes --color=always {} | head -n 500")
# local input_file=$(find ~/Documents/knowledge_vault/Hacking/ -type f | fzf --preview "glow -p {}")
echo $input_file
[[ -z $input_file ]] && exit 1
nvim "${input_file}"
