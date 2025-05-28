#!/bin/bash

set -e

echo "=== Installing prerequisites ==="
sudo apt-get update -y
sudo apt-get install -y unzip apt-transport-https ca-certificates curl gnupg lsb-release python3-pip

echo ""
echo "=== Checking and Installing AWS CLI ==="
if command -v aws &> /dev/null; then
    echo "AWS CLI is already installed: $(aws --version)"
else
    echo "Installing AWS CLI..."
    cd /tmp
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip -q awscliv2.zip
    sudo ./aws/install --update
    echo "AWS CLI installed: $(aws --version)"
fi

echo ""
echo "=== Checking and Installing Azure CLI ==="
if command -v az &> /dev/null; then
    echo "Azure CLI is already installed:"
    az version
else
    echo "Installing Azure CLI..."

    # Setup Microsoft package repo
    sudo mkdir -p /etc/apt/keyrings
    curl -sLS https://packages.microsoft.com/keys/microsoft.asc | \
      gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
    sudo chmod go+r /etc/apt/keyrings/microsoft.gpg

    AZ_DIST=$(lsb_release -cs)
    echo "Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: ${AZ_DIST}
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg" | \
    sudo tee /etc/apt/sources.list.d/azure-cli.sources

    sudo apt-get update -y

    # Try installing via apt
    if sudo apt-get install -y azure-cli; then
        echo "Azure CLI installed via APT:"
        az version
    else
        echo " APT install failed, falling back to pip..."
        pip3 install azure-cli
        echo "Azure CLI installed via pip:"
        az version
    fi
fi

echo ""
echo "Installation check complete."
