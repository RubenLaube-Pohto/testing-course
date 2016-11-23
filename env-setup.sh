#!/bin/bash
# Setup environment in DigitalOcean on 64 bit Ubuntu 16.04
# Installs Docker, Docker Compose and Robot Framework

# Install packages
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual \
    python-pip \
    firefox \
    xvfb

# Docker installation

sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list

sudo apt-get update
sudo apt-get install -y docker-engine
sudo service docker start

sudo docker run hello-world

# Docker Compose 1.9.0

sudo curl -L https://github.com/docker/compose/releases/download/1.9.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo docker-compose --version

# Robot Framework environment setup

# This environment variable needs to be setup for pip
export LC_ALL=C
sudo pip install robotframework robotframework-selenium2library

# Get geckodriver
sudo wget -O /usr/bin/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v0.11.1/geckodriver-v0.11.1-linux64.tar.gz
sudo tar -xzvf /usr/bin/geckodriver.tar.gz -C /usr/bin/
sudo rm /usr/bin/geckodriver.tar.gz

# Test RF setup
echo "*** Settings ***" >> test.txt
echo "Library    Selenium2Library" >> test.txt
echo "*** Test Cases ***" >> test.txt
echo "Selaimen Testaus" >> test.txt
echo "    Open Browser    http://www.google.fi    firefox" >> test.txt
xvfb-run robot test.txt
