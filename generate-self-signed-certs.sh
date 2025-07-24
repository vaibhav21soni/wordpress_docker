#!/bin/bash

# Load environment variables
source .env

# Create certificates directory if it doesn't exist
mkdir -p ./certs/$DOMAIN

# Generate self-signed certificates
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout ./certs/$DOMAIN/privkey.pem \
  -out ./certs/$DOMAIN/fullchain.pem \
  -subj "/CN=$DOMAIN"

echo "Self-signed certificates generated successfully!"
