#!/bin/sh
#sudo su
cd ~;
yum -y install epel-release;
yum -y install nginx;
echo "first server or second server? 1/2"
read server_no
if [ $server_no == "1" ] 
then
	echo "this is first server" > /usr/share/nginx/html/index.html
elif [ $server_no == "2" ]
then
	echo "this is second server" >/usr/share/nginx/html/index.html
else
	break;
fi


systemctl enable nginx;
systemctl start nginx;

echo "enter to view nginx status: ";
systemctl status nginx;
