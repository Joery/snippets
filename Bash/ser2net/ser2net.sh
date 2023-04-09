sudo apt-get install ser2net
sudo mkdir /etc/ser2net
sudo nano /etc/ser2net/ser2net.yaml

  connection: &con0
    accepter: tcp,2001
    connector: serialdev,/dev/ttyUSB0,115200n81,local

sudo nano /lib/systemd/system/ser2net.service

  After=network-online.target
  Wants=network-online.target
  ExecStart=/usr/sbin/ser2net -n -c /etc/ser2net/ser2net.yaml -P /run/ser2net.pid

sudo systemctl daemon-reload
sudo systemctl restart ser2net