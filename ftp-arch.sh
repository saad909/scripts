#1 Install vsftpd
#Install vsftpd package.
# config

sudo pacman -Sy --noconfirm vsftpd
cat <<EOF | sudo tee /etc/vsftpd.conf
listen=YES
local_enable=YES
xferlog_enable=YES
connect_from_port_20=YES
pam_service_name=vsftpd
seccomp_sandbox=NO
# Enable upload by local user.
write_enable=YES
# Enable read by anonymous user (without username and password).
secure_chroot_dir=/var/empty
anonymous_enable=YES
anon_root=/srv/ftp
no_anon_password=YES
EOF

# Step-3 Config - part 2

#Create file in anon_chroot directory.
echo "anon" | sudo tee /srv/ftp/anon.txt


#Step-4 : Enable and restart vsftpd.

sudo systemctl enable vsftpd
sudo systemctl restart vsftpd


# Access to vsftpd
#Access to vsftpd with lftp.
#
#$ sudo pacman -Sy --noconfirm lftp
#Access to vsftpd with specifying user. You can specify password with -u <username>,<password>. Home directory is displayed. You can access directory and files of FTP server with using user permission.
#
#$ lftp -u hiroom2 ftp-server.hiroom2.com
