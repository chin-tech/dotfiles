#!/usr/bin/env bash

pcap=$1


data_dump=$(tshark -r $pcap -Y 'ntlmssp' -T fields -e ntlmssp.auth.username -e ntlmssp.ntlmserverchallenge  -e ntlmssp.ntlmv2_response.nb_domain_name -e ntlmssp.ntlmv2_response.ntproofstr -e ntlmssp.ntlmv2_response | sed '/^[[:space:]]*$/d')

mapfile -t lines <<< "$data_dump"

for (( i=0; i<${#lines[@]}-1; i+=2)); do
    challenge=$(echo -n "${lines[i]}"  | tr -d '[:space:]')
    IFS=$'\t' read -r user domain ntproof full_blob <<< "${lines[i+1]}"
    if [[ -n "$user" && -n "$domain" && -n "$challenge" && -n "$ntproof" && -n "$full_blob" ]]; then
    blob="${full_blob#$ntproof}"
    echo "$user::$domain:$challenge:$ntproof:${blob}"
    fi
done



