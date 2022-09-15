#!/bin/bash

exec > /output.txt 2>&1

# Create a folder
mkdir actions-runner && cd actions-runner

# Download the latest runner package
curl -o actions-runner-linux-x64-2.296.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.296.2/actions-runner-linux-x64-2.296.2.tar.gz

# Optional: Validate the hash
echo "34a8f34956cdacd2156d4c658cce8dd54c5aef316a16bbbc95eb3ca4fd76429a  actions-runner-linux-x64-2.296.2.tar.gz" | shasum -a 256 -c

# Extract the installer
tar xzf ./actions-runner-linux-x64-2.296.2.tar.gz

# Change permissions to a folder actions-runner
sudo chmod -R 755 /var/lib/waagent
sudo chmod -R 777 /var/lib/waagent/custom-script/download/0/actions-runner

# Create the runner and start the configuration experience
printf "Default\nmoonserver\n" | RUNNER_ALLOW_RUNASROOT="1" ./config.sh --url https://github.com/Hookae1/NF-DevOps-Tasks --token AQER23ROYHS2Q7KSRMZJIETDEMT62 

# Last step, run it!
RUNNER_ALLOW_RUNASROOT="1" ./run.sh

exit 0
