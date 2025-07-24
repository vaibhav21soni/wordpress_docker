#!/bin/bash

# Load environment variables
source .env

# Renew certificates using certbot
sudo certbot renew

# Copy renewed certificates to the Docker volume
sudo cp /etc/letsencrypt/live/$DOMAIN/fullchain.pem ./certs/$DOMAIN/
sudo cp /etc/letsencrypt/live/$DOMAIN/privkey.pem ./certs/$DOMAIN/

# Restart Nginx container
docker-compose restart nginx

echo "Certificates renewed and Nginx restarted successfully!"
