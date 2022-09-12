#!/bin/bash

BLUE="\033[34m"
COMMON="\033[0m"
GREEN="\033[42m"
YELLOW="\033[43m"

sudo apt update

# 1. Installation of ATOM

setAtom() {
	if ! [ -x "$(command -v atom)" ]; then
		echo -e "${YELLOW}Error: Atom not installed." >&2	
		echo -e "...Installation of ATOM...${COMMON}"
     		sudo apt install software-properties-common apt-transport-https wget -y
   		wget -q https://packagecloud.io/AtomEditor/atom/gpgkey -O- | sudo apt-key add -
   		sudo add-apt-repository "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main"
   		sudo apt install atom -y
		echo -e "${GREEN}ATOM successfully installed. ATOM version:\n${COMMON}"
		atom --version
	else
		echo -e "${BLUE}ATOM already installed.Version:$COMMON\n"
		atom --version
	fi
}

setAtom

# 2. Installation of Docker

setDocker() {
	if ! [ -x "$(command -v docker)" ]; then
	        echo -e "${YELLOW}Error: Docker not installed.${COMMON}" >&2	 
		echo -e "${YELLOW}...Installation of Docker...${COMMON}"
                sudo apt-get install \
                ca-certificates \
                curl \
                gnupg \
                lsb-release
                sudo mkdir -p /etc/apt/keyrings
                curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
                echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
                $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                sudo apt-get update
                sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
		echo -e "${GREEN}Docker successfully installed. Docker version:${COMMON}\n"
	        docker -v
	else
                echo -e "${BLUE}Docker already installed. Docker version:${COMMON}\n"
		docker -v
       fi
}

setDocker

setJava() {
	if ! [ -x "$(command -v java)" ]; then
		echo -e "${YELLOW}Error: Java not installed." >&2	
		echo -e "...Installation of Java...${COMMON}"
		sudo apt install default-jre -y
		echo -e "${GREEN} Java successfully installed. Java version:${COMMON}\n"
		java --version
	else
		echo -e "${BLUE}Java already installed. Java version:${COMMON}\n"
		java --version
	fi
}

setJava
