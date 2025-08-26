#!/bin/bash

ip_cidr=$(ip a show "${INTERFACE}" | grep -Eo 'inet ([0-9]*\.){3}[0-9]*/[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*/[0-9]*' | head -n 1)

sudo nmap -T4 "${ip_cidr}" -v

curl --interface ${INTERFACE} ipinfo.io
echo -e "\n"
curl --interface ${INTERFACE} ifconfig.xyz
