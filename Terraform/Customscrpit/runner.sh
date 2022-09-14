# Create a folder
mkdir actions-runner && cd actions-runner

# Download the latest runner package
curl -o actions-runner-linux-x64-2.296.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.296.2/actions-runner-linux-x64-2.296.2.tar.gz

# Optional: Validate the hash
echo "34a8f34956cdacd2156d4c658cce8dd54c5aef316a16bbbc95eb3ca4fd76429a  actions-runner-linux-x64-2.296.2.tar.gz" | shasum -a 256 -c

# Extract the installer
tar xzf ./actions-runner-linux-x64-2.296.2.tar.gz

# Create the runner and start the configuration experience
./config.sh --url https://github.com/Hookae1/NF-DevOps-Tasks --token AQER23R254TQIIAQMGINTSDDEDNIQ

# Last step, run it!
./run.sh
