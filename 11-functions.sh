#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "Please run this script with root user access"
    exit 1
fi

pkginstall()
{
    dnf install $1 -y
    if [ $? -eq 0 ]
    then
        echo "Installing $1 ... SUCCESS"
    else
        echo "Installing $1 ... FAILURE"
    fi
}

pkginstall nginx
pkginstall mysql
pkginstall nodejs