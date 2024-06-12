#!/bin/bash
# Update the package repository
sudo yum update -y

# Install Apache
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

# Install MariaDB (MySQL)
sudo yum install -y mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Secure MariaDB installation
mysql_secure_installation <<EOF

y
password
password
y
y
y
y
EOF

# Create a WordPress database and user
sudo mysql -u root -ppassword <<EOF
CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'wppassword';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
EXIT
EOF

# Install PHP and required PHP modules
sudo amazon-linux-extras install -y php7.4
sudo yum install -y php php-mysqlnd

# Download and install WordPress
sudo wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
sudo cp -r wordpress/* /var/www/html/

# Set proper permissions
sudo chown -R apache:apache /var/www/html/
sudo chmod -R 755 /var/www/html/

# Configure WordPress
sudo cd /var/www/html/
sudo cp wp-config-sample.php wp-config.php
sudo sed -i "s/database_name_here/wordpress/" wp-config.php
sudo sed -i "s/username_here/wpuser/" wp-config.php
sudo sed -i "s/password_here/wppassword/" wp-config.php

# Restart Apache to apply changes
sudo systemctl restart httpd

# old script
# #! /bin/bash
# sudo yum update
# sudo yum install -y httpd
# sudo systemctl start httpd
# sudo systemctl enable httpd
# sudo echo "<h1>Deployed via Terraform</hh1>" > /var/www/html/index.html
# sudo systemctl restart httpd