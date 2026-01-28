#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "Please run this script with root user"
    exit
fi
echo "Installing Nginx"
dnf install nginx -y
if [ $? -ne 0 ]; then
    echo "Nginx ... installation failed"
else
    echo "Installing Nginx .. Success"
fi
