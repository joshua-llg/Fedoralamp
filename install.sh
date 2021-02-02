#!/bin/bash


#get the necessary rpms for Lamp server
 sudo dnf install httpd mariadb-server php php-common php-mysqlnd php-xml php-gd php-mbstring
#allow service http & https
 sudo firewall-cmd --permanent --zone=public --add-service=http 
 sudo firewall-cmd --permanent --zone=public --add-service=https
 sudo firewall-cmd --reload

#start httpd & and mariadb temporarely
 sudo systemctl start httpd 
 sudo systemctl start mariadb 
#path to success file
FILE="$HOME/FedoraLamp/success"
# script to set up and install mysql database 
 sudo mysql_secure_installation
echo ""
echo ""
#temporarely stops httpd/mariadb and redirects success input into success file
 sudo systemctl stop httpd
 sudo systemctl stop mariadb 0>> $HOME/FedoraLamp/success
#checks to see if success file exist
if [[ -f $FILE ]];then
	 echo -e "  Lamp install was a successful,\nnow make Server script an executable\n    and sudo ./server up/down "
	 echo ""	 
fi
#this removes success file because it was only needed temporarily
sudo rm -rf $HOME/FedoraLamp/success


exit

