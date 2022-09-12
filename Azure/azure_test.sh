#!/bin/bash

# All resources below would be created by using Azure CLI

NAME=toohes

# Create Azure Resource Group:
az group create --location eastus --name "${NAME}-rg"

# Create Azure Virtual Network
az network vnet create --resource-group "${NAME}-rg" \
    --name "${NAME}-vnet" --address-prefix 10.0.0.0/16 \
    --subnet-name "${NAME}-subnet" --subnet-prefix 10.0.0.0/24

#Create Network Security Group
az network nsg create --name "${NAME}-nsg" \
    --resource-group "${NAME}-rg" \
    --location eastus

# Create Network Security Group Rule
az network nsg rule create --resource-group "${NAME}-rg" \
    --nsg-name "${NAME}-nsg" \
    --name "${NAME}-rule-SSH" \
    --protocol tcp \
    --priority 1000 \
    --destination-port-range 22 \
    --access allow 

# Create Public IP
az network public-ip create --resource-group "${NAME}-rg" \
    --name "${NAME}IP" \
    --dns-name "${NAME}dns"

# Create Virtual NIC
az network nic create --resource-group "${NAME}-rg" \
    --name "${NAME}NIC" \
    --location eastus \
    --vnet-name "${NAME}-vnet" \
    --subnet "${NAME}-subnet" \
    --public-ip-address "${NAME}IP" \
    --network-security-group "${NAME}-nsg"

# Create Virtual Machine
az vm create --resource-group "${NAME}-rg" \
    --name "${NAME}VM" \
    --location eastus \
    --size Standard_B2s \
    --nics "${NAME}NIC" \
    --image UbuntuLTS \
    --admin-username azure \
    --generate-ssh-keys

# Export and save VM template
vmID=$(az resource show --resource-group "${NAME}-rg" --name "${NAME}VM" --resource-type Microsoft.Compute/virtualMachines --query id --output tsv)
az group export --resource-group "${NAME}-rg" --resource-id $vmID > toohesTemplate.json 
