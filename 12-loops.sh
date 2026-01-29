
#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/$0.log"

if [ $USERID -ne 0 ]; then
    echo "Please run this script with root user access" | tee -a $LOGS_FILE
    exit 1
fi

mkdir -p $LOGS_FOLDER

pkginstall()
{
    dnf list $1 --installed  &> /dev/null
    if [ $? -eq 0 ]
    then   
        echo "$1 package is already installed" | tee -a $LOGS_FILE
    else
        echo
        echo "$1 package not installed, installing now ..."
        dnf install $1 -y
        if [ $? -eq 0 ]
        then
            echo "Installing $1 ... SUCCESS" | tee -a $LOGS_FILE
        else
            echo "Installing $1 ... FAILURE" | tee -a $LOGS_FILE
        fi 
    fi
}

for package in $@ # sudo sh 14-loops.sh nginx mysql nodejs
do
    pkginstall $package   # &>>$LOGS_FILE
done
echo "============================= FINISHED =========================" | tee -a $LOGS_FILE
