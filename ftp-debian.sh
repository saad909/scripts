#!/bin/bash
not_installed=$(sudo apt-cache policy  vsftpd | grep "Installed: (none)"|wc -l )

configuration()
{

    #Now adding configs to the ftp server
    sudo echo pasv_min_port=2121 >> /etc/vsftpd.conf
    sudo echo pasv_max_port=2122 >> /etc/vsftpd.conf
    sudo echo write_enable=YES >> /etc/vsftpd.conf
    #Now restart the service and allow firewall rules
    sudo ufw allow 21
    sudo ufw allow 2121
    sudo ufw allow 2122
    sudo systemctl restart vsftpd.service

}


if [ $not_installed == 1  ]
	then
        	printf "Installing required files!\n"
        	sudo apt install vsftpd -y
            printf "Required files installed successfully!\n"
        	
	else
            printf "vsftpd is already installed!\nNow setting it Up!!\n"
        	configuration         

fi


