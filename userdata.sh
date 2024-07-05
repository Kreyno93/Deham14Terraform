#!/bin/bash

# Install updates
sudo yum update -y

# Install Docker
sudo yum install docker -y
sudo systemctl enable docker.service
sudo systemctl start docker.service

# Pull Image
sudo docker pull miischa/rickandmorty-gallery

# Run Container | In this case I am using a personal image that I have uploaded to Docker Hub
# Use different Images for different purposes. Like Nginx for Web Server, MySQL for Database, etc.
sudo docker run -d -p 80:3000 miischa/rickandmorty-gallery

