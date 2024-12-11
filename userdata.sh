#!/bin/bash
# Update system packages
sudo yum update -y

# Install Apache and start the service
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

# Install MySQL client
sudo yum install -y mysql

# Install PHP and required extensions
sudo amazon-linux-extras enable php7.2
sudo yum install -y php php-mysqlnd

# Download and configure WordPress
cd /var/www/html
wget https://wordpress.org/latest.zip
unzip latest.zip
mv wordpress/* .
rm -rf wordpress latest.zip
mv wp-config-sample.php wp-config.php

# Configure wp-config.php
sed -i "s/database_name_here/wordpress/" wp-config.php
sed -i "s/username_here/wordpress/" wp-config.php
sed -i "s/password_here/wordpress123/" wp-config.php
sed -i "s/localhost/wordpress.czuqwk0mw7l4.us-east-1.rds.amazonaws.com/" wp-config.php

# Restart Apache to apply changes
sudo systemctl restart httpd
