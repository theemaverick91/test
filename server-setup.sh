#!/bin/bash

# Update package list
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install necessary packages
echo "Installing OpenSSH server..."
sudo apt install -y openssh-server

# Start SSH service
echo "Starting SSH service..."
sudo service ssh start

# Create a new user for SSH access
echo "Creating user 'githubuser'..."
sudo useradd -m -s /bin/bash githubuser
echo 'githubuser:password123' | sudo chpasswd

# Allow password authentication for SSH
echo "Configuring SSH settings..."
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart ssh

# Display SSH login details
echo "Temporary VPS is ready!"
echo "Login using: ssh githubuser@$(curl -s ifconfig.me)"

# Keep the script running (so the server stays up)
tail -f /dev/null
