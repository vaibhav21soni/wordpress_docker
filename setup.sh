#!/bin/bash

echo "WordPress Docker Setup"
echo "======================"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Load environment variables
source .env

# Create Docker network if it doesn't exist
docker network inspect vaibhav &>/dev/null || docker network create vaibhav

# Ask user if they want to use self-signed certificates
read -p "Do you want to use self-signed certificates for development? (y/n): " use_self_signed

if [[ $use_self_signed == "y" || $use_self_signed == "Y" ]]; then
    # Generate self-signed certificates
    ./generate-self-signed-certs.sh
else
    echo "Please make sure you have valid SSL certificates in the certs/$DOMAIN directory."
    echo "You can use Certbot to obtain certificates as described in the README.md file."
    
    # Check if certificates exist
    if [ ! -f "./certs/$DOMAIN/fullchain.pem" ] || [ ! -f "./certs/$DOMAIN/privkey.pem" ]; then
        echo "Warning: SSL certificates not found. Please add them before starting the containers."
    fi
fi

# Start the containers
echo "Starting Docker containers..."
docker-compose up -d

echo "Setup completed!"
echo "Access your WordPress site at https://$DOMAIN"
echo "Access phpMyAdmin at http://your-server-ip:8080"
