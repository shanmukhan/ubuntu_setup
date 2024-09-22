#!/bin/bash

# 0. Create Group and User
  sudo addgroup ecook
  sudo adduser ecook
  sudo addgroup ecook
  # sudo useradd -s /bin/false -g ecook -d /opt/artemis ecook


# 1. to keep Windows and Ubuntu times are in sync
timedatectl set-local-rtc 1  # this keeps to save time in Local timezone same as Windows


# 2. To keep battery max charge to 80%
echo 80 | sudo tee /sys/class/power_supply/BAT1/charge_control_end_threshold
# to save these settings on reboot
sudo vi /etc/crontab
@reboot root echo 80 > /sys/class/power_supply/BAT1/charge_control_end_threshold


# 3. Install jdk, anaconda and other utils
# sudo apt install openjdk-17-jdk
sudo apt install openjdk-21-jdk
curl -O https://repo.anaconda.com/archive/Anaconda3-<INSTALLER_VERSION>-Linux-x86_64.sh
# ex - https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh
sudo apt install wireshark
sudo apt install meld

sudo snap install libreoffice
sudo snap install gimp
sudo snap install intellij-idea-ultimate
sudo snap install intellij-idea-community
sudo snap install dataspell
sudo snap install code
sudo snap install audacity
sudo snap install flutter


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
  mkdir repo & cd repo
  git clone git@github.com:shanmukhan/vantillu.git
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

  #  lipi@sivakesava:~$ sudo -i -u postgres psql
  #  postgres=# create user ecook with encrypted password '<>';
  #  CREATE ROLE
  #  postgres=# create database vantillu with owner=ecook;
  #  CREATE DATABASE
  #  postgres=# ALTER USER postgres with encrypted password '<>';
  #  ALTER ROLE

  sudo systemctl status postgresql
  sudo systemctl stop postgresql
  sudo systemctl start postgresql

  # to connect to psql using ecook user
  sudo -i -u ecook psql --dbname vantillu



# 8. Install flutter
  sudo snap install flutter --classic


# 9. Install artemis  - https://medium.com/@abdullah.eid.2604/setup-activemq-artemis-on-ubuntu-06951244ee8f
  wget https://dlcdn.apache.org/activemq/activemq-artemis/2.35.0/apache-artemis-2.35.0-bin.tar.gz
  sudo tar -xvzf apache-artemis-2.35.0-bin.tar.gz -C /opt/
  sudo chown -R artemis: apache-artemis-2.35.0
  sudo chmod o+x /opt/apache-artemis-2.35.0/bin/

  cd /var/lib
  sudo /opt/apache-artemis-2.35.0/bin/artemis create ecook

  sudo vi /var/lib/ecook/etc/jolokia-access.xml
  # and remove localhost to give access to all on ui page
  # under <cors> - <allowed-origins>

  sudo vi /var/lib/ecook/etc/bootstrap.xml
  # replace localhost with 0.0.0.0 under <binding> to allow access from every where

  sudo systemctl daemon-reload
  sudo systemctl enable artemis
  sudo systemctl start artemis

  # access http://localhost:8161/console/auth/login for admin page

  # you can run the broker in the background using:
  "/var/lib/ecook/bin/artemis" run

#10. NVIDIA settings
  nvidia-settings -q CUDACores -t
  # 2560
  nvidia-smi
#  Thu Aug 15 22:07:37 2024
#  +---------------------------------------------------------------------------------------+
#  | NVIDIA-SMI 535.183.01             Driver Version: 535.183.01   CUDA Version: 12.2     |
#  |-----------------------------------------+----------------------+----------------------+
#  | GPU  Name                 Persistence-M | Bus-Id        Disp.A | Volatile Uncorr. ECC |
#  | Fan  Temp   Perf          Pwr:Usage/Cap |         Memory-Usage | GPU-Util  Compute M. |
#  |                                         |                      |               MIG M. |
#  |=========================================+======================+======================|
#  |   0  NVIDIA GeForce RTX 4050 ...    Off | 00000000:01:00.0  On |                  N/A |
#  | N/A   43C    P8               4W /  80W |     49MiB /  6141MiB |     35%      Default |
#  |                                         |                      |                  N/A |
#  +-----------------------------------------+----------------------+----------------------+
#
#  +---------------------------------------------------------------------------------------+
#  | Processes:                                                                            |
#  |  GPU   GI   CI        PID   Type   Process name                            GPU Memory |
#  |        ID   ID                                                             Usage      |
#  |=======================================================================================|
#  |    0   N/A  N/A      3196      G   /usr/lib/xorg/Xorg                           45MiB |
#  +---------------------------------------------------------------------------------------+

modinfo nvidia | grep ^version
