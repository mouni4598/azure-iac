#!/bin/bash
set -e

# Get current username and home path
CURRENT_USER=$(whoami)
HOME_DIR=$(eval echo ~$CURRENT_USER)
PLUGIN_FILE="rabbitmq_delayed_message_exchange-4.0.2.ez"
PLUGIN_PATH="$HOME_DIR/$PLUGIN_FILE"

echo "==> Updating system packages..."
sudo apt-get update -y

echo "==> Installing dependencies..."
sudo apt-get install -y ca-certificates curl gnupg lsb-release

echo "==> Setting up Docker GPG key and repository..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "==> Installing Docker Engine and Compose..."
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "==> Docker versions installed:"
docker --version
docker compose version

echo "==> Adding $CURRENT_USER to docker group..."
sudo usermod -aG docker $CURRENT_USER

echo "==> Downloading RabbitMQ delayed message plugin to $PLUGIN_PATH..."
curl -L -o "$PLUGIN_PATH" \
https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/v4.0.2/rabbitmq_delayed_message_exchange-4.0.2.ez

if [ -f "$PLUGIN_PATH" ]; then
  echo "Plugin downloaded successfully to: $PLUGIN_PATH"
else
  echo " Plugin download failed."
  exit 1
fi

echo "==>  Setup complete!"
echo "IMPORTANT: Please log out and log back in (or run 'newgrp docker') to start using Docker without sudo."

