#!/bin/bash


if [ $(id -u) -eq 0 ]; then
        read -p "Enter username : " username
        read -s -p "Enter password : " password
        echo -e '\n'
        read -s -p "Repeat please : " repeat_password
        echo -e '\n'

        if [ $password != $repeat_password ]; then
                echo "Passwords doesn't match!"
                exit 3
        fi

        grep -E "^$username" /etc/passwd >/dev/null

        if [ $? -eq 0 ]; then
                echo "$username exists!"
                exit 1
        else
                useradd -m -s /bin/bash $username
                echo -e $password"\n"$password"\n" | passwd "$username" &>/dev/null
                [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
        fi
else
        echo "Only root may add a user to the system"
        exit 2
fi

