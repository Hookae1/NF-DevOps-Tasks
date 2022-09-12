#!/bin/bash

# 1. Getting context from URL

read -p "Provide URL: " x
wget $x -q -O - > context.txt

# 2. Checking CPU,RAM, disks, network

totalMem() {
	free -h | awk '/^Mem/ {print $2}'
}

avalMem() {
	free -h | awk '/^Mem/ {print $7}'
}

coresCPU() {
        nproc --all
}

usedCPU() {
        top -bn2 | grep '%Cpu' | tail -1 | awk '{print ": " 100-$8 "%"}'
}

usedDisk() {
	df -H | grep "/dev/root" | awk '{print $4}' 
}

listenPorts() {
       sudo lsof -i -P -n | grep LISTEN
}
results() {
        echo "Total RAM: $(totalMem)"
        echo "Avaliable RAM: $(avalMem)"
        echo "Total CPU cores: $(coresCPU)"
        echo "CPU usage: $(usedCPU)"
	echo "Disk space usage: $(usedDisk)"
        echo -e "Listen Ports:\n$(listenPorts)" 	
}

results > results.txt

# 3. Add user and add to sudo group.

## Assign username through stdin
read -p "Enter username: " y
## Create user and adding to sudo group
sudo useradd -m $y && sudo usermod -aG sudo $y
## Checking user presence in groups
id -Gn $y

# 4. Create file and change permissions for only sudo user access (read|write).
ps aux --sort -rss | head -11 > processes.txt  && chgrp sudo processes.txt && sudo chmod 460 processes.txt

# Wrap-up
sudo userdel -r $y


