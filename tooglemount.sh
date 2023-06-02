#!/bin/bash
if grep -qs '/mnt/Drive_1 ' /proc/mounts; then
        echo "Unmounting Drive_1"
        sudo umount /mnt/Drive_1
else
	echo "Pinging NAS..."
        VAR=`ping -s 1 -c 2 192.168.1.240 > /dev/null 2>&1; echo $?`
        if [ $VAR -gt 0 ]; then
                echo "NAS Offline!"
        fi
        if [ $VAR -eq 0 ]; then
                sudo mount -t cifs //IP_NAS/Folder_1 /mnt/Drive_1  -o username=username,password=password,uid=$(id -u),gid=$(id -g),forceuid,forcegid,sec=ntlmv2
                echo "Drive_1 mounted"
        fi
fi

if grep -qs '/mnt/Drive_1 ' /proc/mounts; then
        echo "Unmounting Drive_2"
        sudo umount /mnt/Drive_2
else
        if [ $VAR -gt 0 ]; then
                echo "NAS Offline!"
        fi
        if [ $VAR -eq 0 ]; then
                sudo mount -t cifs //IP_NAS/Folder_2 /mnt/Drive_2 -o username=username,password=password,uid=$(id -u),gid=$(id -g),forceuid,forcegid,sec=ntlmv2
                echo "Drive_2 mounted"
        fi
fi
