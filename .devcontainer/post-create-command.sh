set -e

apt update
apt install -y curl iputils-ping

# Install nvm and Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

export NVM_DIR="/usr/local/share/nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 16.10.0
