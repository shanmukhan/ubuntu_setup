#!/bin/bash

# 1. to keep Windows and Ubuntu times are in sync
timedatectl set-local-rtc 1  # this keeps to save time in Local timezone same as Windows


# 2. To keep battery max charge to 80%
echo 80 | sudo tee /sys/class/power_supply/BAT1/charge_control_end_threshold
# to save these settings on reboot
sudo vi /etc/crontab
@reboot root echo 80 > /sys/class/power_supply/BAT1/charge_control_end_threshold


# 3. Install jdk 17
sudo apt install openjdk-17-jdk


# 4. Install Node
# installs nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# download and install Node.js (you may need to restart the terminal)
nvm install 18

# verifies the right Node.js version is in the environment
node -v # should print `v18.20.3`

# verifies the right NPM version is in the environment
npm -v # should print `10.7.0`

