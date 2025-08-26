#!/bin/bash

read -p "address?: " target_ip

sudo ping -f -s 65500 "$target_ip"
