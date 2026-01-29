
#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/$0.log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]; then
    echo -e "$R Please run this script with root user access $N" | tee -a $LOGS_FILE
    exit 1
fi

mkdir -p $LOGS_FOLDER

pkginstall()
{
    dnf list $1 --installed  &> /dev/null
    if [ $? -eq 0 ]
    then   
        echo -e "$G $1 package is already installed $N" | tee -a $LOGS_FILE
    else
        echo
        echo -e "$R $1 package not installed, $N installing now ...$N" | tee -a $LOGS_FILE
        dnf install $1 -y
        if [ $? -eq 0 ]
        then
            echo -e "$G Installing $1 ... SUCCESS" | tee -a $LOGS_FILE
        else
            echo -e "$R Installing $1 ... FAILURE" | tee -a $LOGS_FILE
        fi 
    fi
}

for package in $@ # sudo sh 14-loops.sh nginx mysql nodejs
do
    pkginstall $package   # &>>$LOGS_FILE
done
echo -e "$Y ============================= $G FINISHED $Y========================= $N" | tee -a $LOGS_FILE
