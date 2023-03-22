sudo apt update && sudo apt -y upgrade && sudo apt -y --purge autoremove
sudo reboot

lsb_release -a
sudo ufw allow 1022/tcp

sudo do-release-upgrade -d

lsb_release -a
sudo ufw delete allow 1022/tcp

sudo apt update && sudo apt -y upgrade && sudo apt -y --purge autoremove