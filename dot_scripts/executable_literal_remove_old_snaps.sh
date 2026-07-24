#!/bin/bash

# Removes old snaps #

snap list --all | awk '/disabled/{print $1, $3}' |
   while read snap_name rev; do 
      snap remove "$snap_name" --revision "$rev"
   done

