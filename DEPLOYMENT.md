Setting Index.html to have the correct environment.

Using sed (Linux/Mac):

# In your CI/CD deployment script
    sed -i "s/window.ENVIRONMENT = 'dev'/window.ENVIRONMENT = 'prod'/" lib/index.html

Absolutely! I can help you set up GitHub Actions for CI/CD. For your Skills Ez application, we could create workflows to:

Automated Deployment - Deploy to your server when you push to main/production branches
Environment Switching - Automatically set window.ENVIRONMENT to 'prod' during deployment
API Server Deployment - Deploy the Dart Frog API server
Database Migrations - Run any SQL migrations if needed
Build & Test - Run tests for the API and shared packages
Multiple Environments - Different workflows for staging and production
We could set up workflows for:

Web App: Copy files to your server via SSH/SCP or deploy to a hosting service
API: Deploy the Dart Frog server to your production environment
Database: Run migrations automatically
Would you like me to create a GitHub Actions workflow? If so, let me know:

How you want to deploy (SSH/SCP to your server, Docker, cloud hosting, etc.)?
Do you need separate staging and production environments?
Should it deploy on every push to main, or only on tagged releases?
I can create the .github/workflows/ configuration files whenever you're ready!

https://nginx.org/en/docs/beginners_guide.html


For production, you should use a proper web server instead of Python's simple HTTP server. Here are the best options:

Web Server Options
1. Nginx (Recommended)

Fast, lightweight, industry-standard
Great for static files
Easy SSL/HTTPS setup
Reverse proxy for your Dart Frog API
2. Caddy

Automatic HTTPS with Let's Encrypt
Very simple configuration
Perfect if you want "zero-config" SSL
3. Apache

More features/flexibility
Heavier than Nginx
For HTTPS (SSL/TLS), you have options:
If you have a domain name:

Use Let's Encrypt (free SSL certificates)
Nginx + Certbot handles it automatically
For internal network only:

Use self-signed certificates
Or keep HTTP if it's just local
Quick Setup Guide
Would you like me to create:

Nginx configuration for your Skills Ez site + API reverse proxy?
SSL setup instructions with Let's Encrypt (if you have a domain)?
Systemd service files to auto-start your API server?
Docker setup (optional, for easier deployment)?
Let me know:

Do you have a domain name for this site?
Is this for public internet or just your local network?
Are you running this on Linux/Mac?
I can create the complete Nginx config and deployment setup for your specific situation!


SSetting up the NGINX Supported website
sudo mkdir /var/www/skills-ez.me
sudo mkdir /var/www/skills-ez.me/html
sudo cp -r ~/applications/skillsez/lib/*.* /var/www/skills-ez.me/html

  sudo chown -R www-data:www-data /var/www/skills-ez.me/html
sudo tail -f /var/log/nginx/error.log
sudo find /var/www/skills-ez.me/html -type d -exec chmod 755 {} \;
sudo find /var/www/skills-ez.me/html -type f -exec chmod 755 {} \;
sudo usermod -aG www-data $USER
exit
sudo -u www-data cat /var/www/skills-ez.me/html/index.html
sudo systemctl reload nginx

  sudo chown www-data:www-data /var/www/skills-ez.me/app
  sudo find /var/www/skills-ez.me/html -type d -exec chmod 755 {} \;
  sudo find /var/www/skills-ez.me/html -type f -exec chmod 755 {} \;
  sudo usermod -aG www-data $USER

# Background Service for App
## Compile to make it a service

    dart_frog build
    dart compile exe build/bin/server.dart -o frog_server
    sudo chmod +x /var/www/ka-ikena.tech/app/frog_server

## Setting up the frog server as a service

### Configuration File
    /etc/systemd/system/dart_frog.service

[Unit]
Description=Dart Frog Backend Service
After=network.target

[Service]
# Run as a specific user (highly recommended)
User=www-data
Group=www-data

# Set the working directory
WorkingDirectory=/var/www/skills-ez.me/app

# Path to your compiled executable
ExecStart=/var/www/skills-ez.me/app/server

# Automatically restart on crash
Restart=always
RestartSec=5

# Environment variables (optional)
Environment=GEMINI_API_KEY=gemini_api_pey
Environment=PORT=8080
Environment=NODE_ENV=production
Environment=DB_PASSWORD=mysql_password
Environment=DB_HOST=localhost
Environment=DB_PORT=3306
Environment=DB_NAME=SKILLS_EZ
Environment=DB_USER=rob

[Install]
WantedBy=multi-user.target

Starting the service:

sudo systemctl daemon-reload
sudo systemctl start dart_frog.service
sudo systemctl enable dart_frog.service
sudo systemctl status dart_frog.service

Checking that it's running
sudo lsof -i :8080


### Runbook Setting Up SSL/TLS for NGINX

Here’s a minimal, production‑ready Certbot flow for Nginx on skillsez.me:

Ensure DNS A/AAAA records point to your server, and ports 80/443 are open.
Verify your Nginx server block includes server_name skillsez.me www.skillsez.me;.
Install Certbot for Nginx (package varies by distro).
Run Certbot with Nginx plugin for both domains: certbot --nginx -d skillsez.me -d www.skillsez.me
(this auto‑edits Nginx, installs certs, and sets the redirect).
Reload Nginx.
Confirm auto‑renew is enabled (systemd timer or cron).

Example commands (Ubuntu/Debian):

  sudo apt updatecd 
  sudo apt install certbot python3-certbot-nginx
  sudo certbot --nginx -d skillsez.me -d www.skillsez.me
  sudo nginx -t
  sudo systemctl reload nginx
  sudo systemctl status certbot.timer


### Runbook for Setting Up NGINX server for skills-ez.me Configuration

Located in: /etc/nginx/sites-available

server {

    root /var/www/skills-ez.me/html;
    index index.html index.htm;

    server_name skillsez.me  www.skillsez.me;

    location / {
        try_files $uri $uri/ =404;
    }

    # API (Dart Frog on localhost:8080)
    location /api/ {
        proxy_pass http://127.0.0.1:8080/;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    listen 443 ssl; # managed by Certbot
    listen [::]:443 ssl ipv6only=on; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/skillsez.me/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/skillsez.me/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}
server {
    if ($host = www.skillsez.me) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = skillsez.me) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    listen [::]:80;

    server_name skillsez.me  www.skillsez.me;
    return 404; # managed by Certbot
}

### Runbook for setting up MariaDB Open Connections From Other Servers

# Check what interface/ip and port Maria DB listens on
sudo ss -tulnp | grep mariadb

# Add the line "bind-address = 0.0.0.0" to the 50-server.cnf
sudo /etc/mysql/mariadb.conf.d/vim 50-server.cnf

# Stop the service
sudo systemctl stop mysql

# Check the variable values (this hasn't worked for me)
/usr/bin/mariadb --print-defaults

# Start the service
sudo systemctl start mysql

# Check status that it started
sudo systemctl status mysql

### Runbook for Getting Production Information

# get the name of the service
systemctl list-units --type=service --state=running

# View the status of the dart_frog.service and PID
systemctl status dart_frog.service

# Get the PID of the dart_frog.service
PID=$(systemctl status dart_frog.service | grep -Po '(?<=PID: )\d+')
echo $PID

# View the environment variables of the dart_frog.service using the PID
sudo strings /proc/$PID/environ


### Runbook Setup Rsync Backup using SSH

# Log into the skills EZ server
    ssh <sudo-user>@skills-ez-server

# Create backup admin account on skills EZ server
    sudo adduser backup-admin

# Grant read access for the backup sources
    sudo setfacl -R -m u:backup-admin:rx /var/lib/mysql
    
## Setup Backup User on backup server Raspi-ssd

# Log into the backup server Raspi-ssd
    ssh <sudo-user>@raspi-ssd

# Create the backup admin 
    sudo adduser backup-admin

# Setup write access
    sudo setfacl -R -m u:backup-admin:rwx /mnt/data/skills-ez-server-bu
# Verify Settings
    getfacl /mnt/data/skills-ez-server-bu
        

# Become the backup admin
    su - backup-admin

# generate the private/public key pair

    ssh-keygen -t rsa

    When prompted for a file path, you can press Enter to accept the default location (~/.ssh/id_rsa).

    When prompted for a passphrase, you can press Enter twice for an empty passphrase if you want fully automated, passwordless operation (common for automated scripts/cron jobs). For interactive use, setting a passphrase adds an extra layer of security. 

# copy the public key to the skills EZ server
    ssh-copy-id -i ~/.ssh/id_rsa.pub backup-admin@skills-ez-server

    The ssh-copy-id command automatically appends your public key to the ~/.ssh/authorized_keys file on the remote server and sets the correct permissions. 

    If ssh-copy-id is not available, you can use cat and ssh manually:

    cat ~/.ssh/id_rsa.pub | ssh user@remote_host_ip "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys".

# verify SSH access to the remote server

     ssh backup-admin@skills-ez-server

# Test the backup
rsync -avz --dry-run backup-admin@skills-ez-server:/var/lib/mysql/ /mnt/data/skills-ez-server-bu

# Use Rsync with SSH Access

    Pushing files (Local to Remote):
        rsync -avz /local/path/ user@remote_host_ip:/remote/path/ 

    Pulling files (Remote to Local):
        rsync -avz user@remote_host_ip:/remote/path/ /local/path/ 

    The common options used here are:
    -a: archive mode (preserves permissions, ownership, timestamps, recursive, etc.)
    -v: verbose (shows what's happening)
    -z: compress file data during the transfer
    -O: ommit setting modification times on the directories

    Addressing the rsync: failed to set times on "/foo/bar": Operation not permitted (1) issue

    Rsync seems to work, but we want to get rid of the error. Still working this issue. Some options are:

    --no-times:  By default (or when using -t or the archive flag -a), rsync transfers the modification times of the source files to the destination. This allows it to efficiently determine if files have changed in future syncs by comparing timestamps and sizes. This sacrifices efficiency
    since the times on the destination and source will always differ and the file will have to transfer. 

    --omit-dir-times, -O     omit directories from --times
    --omit-link-times, -J    omit symlinks from --times  

    Changing file permissions eliminates the error, but it's not a good fix.

    By default (or when using -t or the archive flag -a), rsync transfers the modification times of the source files to the destination. This allows it to efficiently determine if files have changed in future syncs by comparing timestamps and sizes.

    
    
    Also changed the logging. Verify this works correctly then address the other issues:

    --log-file=FILE          log what we're doing to the specified FILE
    --log-file-format=FMT    log updates using the specified FMT


    rsync -avz backup-admin@skills-ez-server:/var/lib/mysql/ /mnt/data/skills-ez-server-bu

## Setup Cron Job for Backup Admin

# log in as your user

# Create a backup file for the Cron Job
    sudo chown backup-admin:backup-admin /mnt/data/skills-ez-server-bu/skills-ez-backup.log

# Set ownweship on the logfile
    sudo chown root:backup-admin /mnt/data/skills-ez-server-bu/skills-ez-backup.log

# Change to backup-admin user
    su - backup-admin

# test the command for the crontab
    sudo -u backup-admin /bin/sh -c "cd ~ && rsync -avz  --log-file=/mnt/data/skills-ez-server-bu/skills-ez-backup.log  backup-admin@skills-ez-server:/var/lib/mysql/ /mnt/data/skills-ez-server-bu"

# Open the crontab for editing
    crontab -e

# Set the job to a short interview for verification

    */2 * * * * rsync -avz  --log-file=/mnt/data/skills-ez-server-bu/skills-ez-backup.log  backup-admin@skills-ez-server:/var/lib/mysql/ /mnt/data/skills-ez-server-bu

    Interval set to every two minutes to verify there's no syntax errors

    Alternate Method:

    (crontab -l | sed 's/^\*\/2\s+*/0 3 */') | crontab - 


# Monitor output
    tail -f /mnt/data/skills-ez-server-bu/skills-ez-backup.log

# Correct start time
    crontab -e

# Update the start time for executing the backup

    replace */2 * * * * with 0 3 * * *

    0 3 * * * rsync -avz  --log-file=/mnt/data/skills-ez-server-bu/skills-ez-backup.log  backup-admin@skills-ez-server:/var/lib/mysql/ /mnt/data/skills-ez-server-bu

    This will run the RSYNC command at 03 (3 AM) Each Morning, logging the output to the log file.

# Verify the crontab update was correct by running
    contrab -l

### Setting up MySQL Logging

    Changes are made to the file:  /etc/mysql/mariadb.conf.d/50-server.cnf

# Setting up testing/debugging logging
    # Note: The configured log file or its directory need to be created
    # and be writable by the mysql user, e.g.:
    # $ sudo mkdir -m 2750 /var/log/mysql
    # $ sudo chown mysql /var/log/mysql

    # Both location gets rotated by the cronjob.
    # Be aware that this log type is a performance killer.
    # Recommend only changing this at runtime for short testing periods if needed!
    general_log_file       = /var/log/mysql/mysql.log
    general_log            = 1

# Monitoring the log file
    sudo tail -f /var/log/mysql/mysql.log


# Setting up logging to the system logs
    # When running under systemd, error logging goes via stdout/stderr to journald
    # and when running legacy init error logging goes to syslog due to
    # /etc/mysql/conf.d/mariadb.conf.d/50-mysqld_safe.cnf
    # Enable this if you want to have error logging into a separate file
    log_error = /var/log/mysql/error.log

### Monitor System Log Files (or the local log file) 
    sudo tail -f /var/log/mysql/error.log
# Viewing the system logs
    sudo journalctl -u mysql.service

# monitoring in real-time
    sudo journalctl -u mysql.service -f

### Update Profile Failed

# Interface Error
    [PUT /user/2] Internal server error: MySQLClientException: Can not close connection. Connection state is not in connectionEstablished state

# Log File Error
    260213 15:53:19	    7 Connect	rob@localhost on SKILLS_EZ using SSL/TLS
		                7 Connect	Access denied for user 'rob'@'localhost' (using password: YES)

# Root Cause
    The user DB_USER password was changed in the database and this caused the interface to fail.

# Fix
    Changing the DB_USER password back to the correct password (see production project secrets in github) fixed the issue.

# Solution
    Note in the configuration documents that the database password must by syncronized in the deployment documents. Perhaps also have a procedure for changing the passwords in the database.

