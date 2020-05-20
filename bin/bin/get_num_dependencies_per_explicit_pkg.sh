pacman -Qei | grep -E "(Name|Depends)" | sed -e "s/^[Depends On].*: //g" -Ee "s/Name.*:\s*(\S+)/\1: /g" | awk '{ if(NR % 2) { printf $0 } else { print NF } }' | sort -t : -k 2 -Vr

