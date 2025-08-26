#!/bin/bash

# The setup script for Raspberry Pi OS (Bookworm)

set -e

echo -e "\n[*] Updating package list...\n"
sudo apt update

echo -e "\n[*] Full system update...\n"
sudo apt full-upgrade -y

echo -e "\n[*] Installing wired attack tools and dependencies...\n"
sudo apt install curl wget nmap -y

read -p "Do you want to install tailscale? (Y/n): " tailscale
if [ "${tailscale^^}" != "N" ]; then
	echo -e "\n[*] Installing tailscale...\n"
	curl -fsSL https://tailscale.com/install.sh | sh
	sudo systemctl enable tailscaled
	sudo systemctl start tailscaled
	echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
	echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
	sudo sysctl -p /etc/sysctl.d/99-tailscale.conf
	echo -e "\n[*] Tailscale installed\n"
fi

echo -e "\n[*] All dependencies installed.\n"

# This makes the connection between the raspberry pi and a phone more stable
echo -e "\n[*] Disabling wlan0 power management...\n"

cat <<EOF | sudo tee "/etc/NetworkManager/conf.d/disable-wifi-powersave.conf" > /dev/null 
[connection]
wifi.powersave = 2
EOF

read -p "Which eth device will you be using? (eg. eth0): " interface

echo -e "export INTERFACE=${interface}" >> ~/.bashrc

source ~/.bashrc

echo -e "\n[*] Restarting NetworkManager... This will temporarily disconnect the raspberry pi from your hotspot\n"
sudo systemctl restart NetworkManager

echo "[*] Setup completed, scripts ready for use."
