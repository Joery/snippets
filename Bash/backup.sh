#!/bin/bash

tar -zcf "/home/user/upload/Docker-$(date +%F).tar.gz" "/home/user/docker/"
/usr/bin/rclone copy "/home/user/upload/Docker-$(date +%F).tar.gz" "xxx:Backup"
rm "/home/user/upload/Docker-$(date +%F).tar.gz"