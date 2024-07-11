#!/bin/bash

# 1. to keep Windows and Ubuntu times are in sync
timedatectl set-local-rtc 1  # this keeps to save time in Local timezone same as Windows


# 2. To keep battery max charge to 80%
echo 80 | sudo tee /sys/class/power_supply/BAT1/charge_control_end_threshold
# to save these settings on reboot
sudo vi /etc/crontab
@reboot root echo 80 > /sys/class/power_supply/BAT1/charge_control_end_threshold


# 3. Install jdk 17, 21
sudo apt install openjdk-17-jdk
sudo apt install openjdk-21-jdk


# 4. Install Node
# installs nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# download and install Node.js (you may need to restart the terminal)
nvm install 18

# verifies the right Node.js version is in the environment
node -v # should print `v18.20.3`

# verifies the right NPM version is in the environment
npm -v # should print `10.7.0`


# 5. Install git
sudo apt install git


# 6. SSH and github setup
  ssh-keygen -t ed25519 -C "shanmukhan.b@gmail.com"
  ssh-add ~/.ssh/id_ed25519
  cat ~/.ssh/id_ed25519.pub
  pwd
  ls -l
  mkdir repo
  ls -l
  cd repo/
  git clone git@github.com:shanmukhan/vantillu.git
  sudo apt install git
  git clone git@github.com:shanmukhan/vantillu.git
  ls -l
  git clone :shanmukhan/food_pi.git
  git clone git@github.com:shanmukhan/food_pi.git
  git clone git@github.com:shanmukhan/vantillu-fe.git
  git clone git@github.com:shanmukhan/ccme.git
  git clone git@github.com:shanmukhan/iot.git
  git clone git@github.com:shanmukhan/ubuntu_setup.git


# 7. Install postgres and pgadmin
  sudo apt install postgresql
  curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
  sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
  sudo apt install pgadmin4


# 8. Install flutter
  sudo snap install flutter --classic


# 9. Install artemis
  wget https://dlcdn.apache.org/activemq/activemq-artemis/2.35.0/apache-artemis-2.35.0-bin.tar.gz
  sudo tar -xvzf apache-artemis-2.35.0-bin.tar.gz -C /opt/
  sudo chown -R artemis: apache-artemis-2.35.0
  sudo chmod o+x /opt/apache-artemis-2.35.0/bin/

  cd /var/lib
  sudo /opt/apache-artemis-2.35.0/bin/artemis create ecook

  # you can run the broker in the background using:
  "/var/lib/ecook/bin/artemis" run


# 10.
