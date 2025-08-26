#!/bin/bash

if ! command -v tailscale &> /dev/null; then
	echo "Tailscale not found, install it from the tailscale.com website"
	exit 1
fi

ip -c a

read -p "Enter the route to use (192.168.1.0/24): " route
sudo tailscale up --advertise-exit-node --advertise-routes $route
