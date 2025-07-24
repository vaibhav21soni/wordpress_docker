# 🐳 WordPress Docker Setup with SSL

This repository contains a complete Docker setup for running WordPress with Nginx, PHP-FPM, MySQL, and SSL support.

## 📋 Components

- **WordPress**: Latest version
- **Nginx**: Web server with SSL configuration
- **PHP-FPM 8.1**: PHP FastCGI Process Manager with optimized extensions
- **MySQL 5.7**: Database server
- **phpMyAdmin**: Database management tool

## 🚀 Getting Started

### Prerequisites

- Docker and Docker Compose installed
- Domain name pointing to your server (currently configured for `testings.aftl.biz`)
- SSL certificates for your domain (or use self-signed for development)

### 📁 Directory Structure

```
wordpress_docker/
├── docker-compose.yml    # Docker Compose configuration
├── .env                  # Environment variables
├── nginx/                # Nginx configuration
│   └── default.conf      # Virtual host configuration
├── php/                  # PHP configuration
│   └── Dockerfile        # PHP Docker image configuration
├── wordpress/            # WordPress files
├── certs/                # SSL certificates (to be created)
│   └── testings.aftl.biz/
│       ├── fullchain.pem
│       └── privkey.pem
├── setup.sh              # Setup script
├── generate-self-signed-certs.sh  # Script to generate self-signed certificates
├── renew-certs.sh        # Certificate renewal script
└── README.md             # This file
```

## 🛠️ Quick Setup

The easiest way to get started is to use the setup script:

```bash
./setup.sh
```

This script will:
1. Check if Docker and Docker Compose are installed
2. Create the Docker network if it doesn't exist
3. Ask if you want to use self-signed certificates for development
4. Start the Docker containers

## 🔒 SSL Certificate Setup

### Option 1: Using Certbot with DNS Challenge

1. Install Certbot and required plugins:
   ```bash
   sudo apt update
   sudo apt install certbot
   ```

2. Request a certificate using DNS challenge:
   ```bash
   sudo certbot certonly \
     --manual \
     --preferred-challenges dns \
     --debug-challenges \
     -d testings.aftl.biz
   ```

3. Create the certificates directory and copy the files:
   ```bash
   mkdir -p ~/wordpress_docker/certs/testings.aftl.biz
   sudo cp /etc/letsencrypt/live/testings.aftl.biz/fullchain.pem ~/wordpress_docker/certs/testings.aftl.biz/
   sudo cp /etc/letsencrypt/live/testings.aftl.biz/privkey.pem ~/wordpress_docker/certs/testings.aftl.biz/
   ```

### Option 2: Using Self-Signed Certificates (for development only)

Run the provided script:
```bash
./generate-self-signed-certs.sh
```

## 🚀 Manual Deployment

If you prefer to deploy manually:

1. Create the external network if it doesn't exist:
   ```bash
   docker network create vaibhav
   ```

2. Start the containers:
   ```bash
   docker-compose up -d
   ```

3. Access your WordPress site at https://testings.aftl.biz

4. Access phpMyAdmin at http://your-server-ip:8080

## 🔄 Certificate Renewal

To renew your SSL certificates, use the provided script:

```bash
./renew-certs.sh
```

This script will:
1. Renew the certificates using Certbot
2. Copy the renewed certificates to the Docker volume
3. Restart the Nginx container

## 🔧 Environment Configuration

The `.env` file contains all the environment variables used by the Docker Compose configuration:

- `MYSQL_DATABASE`: The name of the MySQL database
- `MYSQL_USER`: The MySQL user
- `MYSQL_PASSWORD`: The MySQL user password
- `MYSQL_ROOT_PASSWORD`: The MySQL root password
- `DOMAIN`: Your domain name

You can modify these values to suit your needs.

## 🛡️ Security Considerations

- Change the default database credentials in the `.env` file
- Use strong passwords
- Keep your WordPress installation and plugins updated
- Consider implementing additional security measures like fail2ban or a Web Application Firewall
