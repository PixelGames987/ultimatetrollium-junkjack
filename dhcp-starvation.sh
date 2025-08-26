#!/bin/bash

read -p "packets/sec?: " packets

sudo .scripts/dhcp-starvation $INTERFACE $packets
