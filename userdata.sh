#! /bin/bash

 # Creates a simple httpd webserver

    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl start httpd
    sudo systemctl enable httpd
    echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
    sudo systemctl restart httpd