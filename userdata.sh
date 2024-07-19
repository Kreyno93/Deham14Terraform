#!/bin/bash

# Install updates
sudo yum update -y

# Install Apache server
sudo yum install -y httpd

# Configure aws cli

# # Variables for AWS credentials
# AWS_ACCESS_KEY_ID="${aws_access_key_id}"
# AWS_SECRET_ACCESS_KEY="${aws_secret_access_key}"
# AWS_DEFAULT_REGION="${aws_default_region}"

# # Configure AWS CLI with the provided credentials
# aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
# aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
# aws configure set default.region $AWS_DEFAULT_REGION

# echo "AWS CLI configured successfully."


# Install MariaDB, PHP, and necessary tools
sudo amazon-linux-extras install -y php8.0
sudo amazon-linux-extras enable mariadb10.5
sudo yum clean metadata
sudo yum install -y mariadb unzip


# Set database variables
DBName="wordpress"
DBUser="wordpress"
DBPassword="admin1234"
DBRootPassword="rootpassword1234"
DBHost="localhost"

# Set database variables for RDS and Wordpress
# DBName="wordpress"
# DBUser="wordpress"
# DBPassword="admin1234"
# RDS_ENDPOINT="${rds_endpoint}"

# Start Apache server and enable it on system startup
sudo systemctl start httpd
sudo systemctl enable httpd

# Start MariaDB service and enable it on system startup
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Wait for MariaDB to fully start
sleep 10

# Set MariaDB root password
sudo mysqladmin -u root password "$DBRootPassword"

# Download and install WordPress
sudo wget http://wordpress.org/latest.tar.gz -P /var/www/html
cd /var/www/html
sudo tar -zxvf latest.tar.gz
sudo cp -rvf wordpress/* .
sudo rm -R wordpress
sudo rm latest.tar.gz

# Making changes to the wp-config.php file, setting the DB name
sudo cp ./wp-config-sample.php ./wp-config.php 
sudo sed -i "s/'database_name_here'/'$DBName'/g" wp-config.php
sudo sed -i "s/'username_here'/'$DBUser'/g" wp-config.php
sudo sed -i "s/'password_here'/'$DBPassword'/g" wp-config.php
sudo sed -i "s/'localhost'/'$DBHost'/g" wp-config.php
# sudo sed -i "s/'localhost'/'$RDS_ENDPOINT'/g" wp-config.php

# Grant permissions
sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www/
sudo chmod 2775 /var/www/
sudo find /var/www/ -type d -exec chmod 2775 {} \;
sudo find /var/www/ -type f -exec chmod 0664 {} \;

# Create WordPress database
sudo echo "CREATE DATABASE IF NOT EXISTS $DBName;" | mysql -u root --password=$DBRootPassword
sudo echo "CREATE USER IF NOT EXISTS '$DBUser'@'localhost' IDENTIFIED BY '$DBPassword';" | mysql -u root --password=$DBRootPassword
sudo echo "GRANT ALL ON $DBName.* TO '$DBUser'@'localhost';" | mysql -u root --password=$DBRootPassword
sudo echo "FLUSH PRIVILEGES;" | mysql -u root --password=$DBRootPassword

# # Create WordPress database - commented out due to version error. had mariadb 5.5 previously
# echo "CREATE DATABASE \`${DBName}\`;" | mysql -u root --password="$DBRootPassword"
# echo "CREATE USER '$DBUser'@'localhost' IDENTIFIED BY '$DBPassword';" | mysql -u root --password="$DBRootPassword"
# echo "GRANT ALL ON \`${DBName}\`.* TO '$DBUser'@'localhost';" | mysql -u root --password="$DBRootPassword"
# echo "FLUSH PRIVILEGES;" | mysql -u root --password="$DBRootPassword"
