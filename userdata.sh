#! /bin/bash
sudo yum update
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo "<h1>Deployed via Terraform</hh1>" > /var/www/html/index.html
sudo systemctl restart httpd