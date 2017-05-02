function lan_wan_ip() {

echo "#####################################"
echo "IPV4/IPV6 INFORMATION"
echo "#####################################"
echo -e "\n"

echo "===============EXTERNAL IP=================="
wanip=`wget -q -O - http://ip.keithscode.com`
echo "Your external IP address is:  $wanip"
echo -e "\n"

echo "===============LOOPBACK====================="
loopback="$(ip addr show|grep "LOOPBACK" -A 5|grep "inet "|awk '{print $2}')"
echo "Your loopback address is: $loopback"
echo -e "\n"

echo "==================IPV4====================="
broadcast="$(ip addr show|grep "BROADCAST" -A 5|grep "inet "|awk '{print $2}')"
echo "Your IPV4 address is: $broadcast"

v4MAC="$(ip addr show | grep -w ether | awk '{print $2}')"
echo "Your IPV4 MAC Address is: $v4MAC"

v4NETMASK="$(/usr/sbin/ifconfig | grep "BROADCAST" -A 5 |grep "netmask "| awk '{print $4}')"
echo "Your IPV4 Net-Mask is: $v4NETMASK"

v4Broadcast="$(/usr/sbin/ifconfig | grep "BROADCAST" -A 5 |grep "broadcast "| awk '{print $6}')"
echo "Your IPV4 BroadCast IP is: $v4Broadcast"
echo -e "\n"


echo "==================IPV6====================="
broadcastVSix="$(ip addr show|grep "BROADCAST" -A 5|grep "inet6 "|awk '{print $2}')"
echo "Your IPV6 address is: $broadcastVSix"

prefixV6="$(ip addr | grep -w inet6 |grep -v ::1 |awk '{print $2}' | cut -d "/" -f 2)"
echo "Your IPV6 Prefix is: $prefixV6"
echo -e "\n"

echo "#########################################################"
}


function diskInfo() {

printf "Memory\t\tDisk\t\tCPU\n"
end=$((SECONDS+30))
while [ $SECONDS -lt $end ];
do

MEMORY=$(free -m |awk 'NR==2{printf "(%.2f%%)\t",$3*100/$2 }')
DISK=$(df -h | awk '$NF=="/"{printf "(%s)\t\t",$5}')
CPU=$(top -bn1 |grep load |awk '{printf "(%.2f%%)\t\t\n", $(NF-2)}')

echo "$MEMORY$DISK$CPU"


sleep 3
done

echo -e "\n"
echo -n "Would you like to perform another stress test (y/n): "
read answer
echo -e "\n"

if [ "$answer" == "y" ]
then
        diskInfo
        echo `clear`

elif [ "$answer" != "y" ]
then
        echo -n `clear`
        exec ./Muhammad_Hafeez_IT_240_Project.txt

fi
}

function diskwarning(){

echo "This script is going to start a stress test which will last for 30 seconds."
echo "It is going to monitor MEMORY / DISK / CPU usage and after the time is up."
echo "It will stop the stress test and the system admin will be able to see the results."
echo -e "\n"
echo -n "Do you wish to continue (y/n): "
read result
echo -e "\n"

if [ "$result" == "y" ]
then
        diskInfo
        echo `clear`

elif [ "$result" == "n" ]
then
        echo -n `clear`
        exec ./Muhammad_Hafeez_IT_240_Project.txt

fi

}


function calculator(){
echo "-----------------------Calculator------------------------"
echo "1:ADD"
echo "2:SUBTRACT"
echo "3:MULTIPLY"
echo "4:DIVIDE"
echo "5:EXIT"

echo -e "\n"
echo -n "Enter your selection: "
read check

if test $check -eq 1
then
	echo -e "\n"
	echo -e "Addition"
        echo -n "Enter the 1st number: "
        read x
	echo -n "Enter the 2nd number: "
        read y
        res=`expr $x + $y`
	echo -e "\n"
        echo "Result is: $res"

sleep 2

elif test $check -eq 2
then
	echo -e "\n"
	echo -e "Subtraction"
	echo -n "Enter the 1st number: "
	read x
        echo -n "Enter the 2nd number: "
        read y
        res=`expr $x - $y`
	echo -e "\n"
        echo "Result is: $res"

sleep 2

elif test $check -eq 3
then
	echo -e "\n"
        echo -e "Multiply"
        echo -n "Enter the 1st number: "
        read x
        echo -n "Enter the 2nd number: "
        read y
        res=`expr $x \* $y`
	echo -e "\n"
        echo "Result is: $res"

sleep 2

elif test $check -eq 4
then
        echo -e "\n"
        echo -e "Divide"
        echo -n "Enter the 1st number: "
        read x
        echo -n "Enter the 2nd number: "
        read y
        res=`expr $x / $y`
        echo -e "\n"
        echo "Result is: $res"

sleep 2

else
        echo "Stopping the script"
fi

echo -e "\n"
echo -n "Do you want to continue (y/n): "
read continue

if [ "$continue" == "y" ]
then
	echo -n `clear`
	calculator

elif [ "$continue" == "n" ]
then
	echo -n `clear`
	exec ./Muhammad_Hafeez_IT_240_Project.txt
fi 
}

function permission(){
echo -e "\n"
echo -e "Warning: You need to be ROOT in order to add user and move them in specific group"
echo -n "Would you like to be root (y/n): "
read answer
if [ "$answer" == "y" ]
then
	addingUser

elif [ "$response" == "n" ]
then
        echo -n `clear`
	exec ./Muhammad_Hafeez_IT_240_Project.txt
fi
}

function addingUser() {
repeat=1
counter=0
while [ $repeat -eq 1 ];
do
	echo -e "\n"
	echo -n "Please enter the username for the new user: "
        read username
	sudo useradd $username
	sudo passwd $username
	
        counter=$counter+1
        while [ $repeat -eq 1 ];
        do
		echo -e "\n"
		echo -n "Please enter the name of the group to put the new user into: "
		read groupName
		if [ "$(getent group $groupName)" != "" ]; then
			sudo adduser $username $groupName
                        repeat=0
		else
                        echo "The group "$groupName" does not exist"
                        echo -n "Do you want to create it as a new user (y) OR enter another group to add the user "$username" to: "
                        read input
                        if [ "$input" = "y" ];
                        then
                                sudo groupadd $groupName
                                #sudo usermod -G $groupName $username
				sudo adduser $username $groupName
                                repeat=0
                        
			elif [ "$input" != "y" ];
                        then
                                if [ $(getent group $groupName) -eq "$groupName" ]; then
                                sudo adduser $username $groupName
                        else
                                echo "The group "$groupName" does not exist"
                                echo -n "Do you want to create it as a new user (Y) OR enter another group to add the user "$username" to: "
                                echo "Success"
                fi
        fi
fi
done

echo -e "\n"
echo -n "Do you want to create another user? (Y/N) "
read input
if [ $input = "N" ]; then
        repeat=0
else
        repeat=1
fi
done
echo "You have successfully created "$username" new user(s) and added them to "$groupName" group(s)"

}

function deleteUser() {
repeat=1
while [ $repeat -eq 1 ];
        do
	echo -e "\n"
        echo -n "Please enter the username that you want to delete: "
        read username
	echo -e "\n"
        echo -n "Please enter the group name that you want this user to be deleted from: "
        read groupName
        sudo deluser $username
	repeat=0
	
	echo -e "\n"
	echo -n "Would you like to delete another user (y/n): "
	read answer

	if [ "$answer" == "y" ]
	then
		echo `clear`
		deleteUser
	
	elif [ "$answer" == "n" ]
	then
		echo -n `clear`
		exec ./Muhammad_Hafeez_IT_240_Project.txt
fi

done

echo -e "\n"
echo "You have successfully deleted $username from $groupName group"

}

function add_delete() {

echo -n "Do you want to add a user or delete a user: "
read word

if [ "$word" == "add" ]
then
        permission

elif [ "$word" == "delete" ]
then
        deleteUser

elif [ "$word" == "" ]
then
        echo -n `clear`
        exec ./Muhammad_Hafeez_IT_240_Project.txt
fi
}

function backup(){

echo -e "Welcome to BACKUP Script"

mkdir $HOME/Desktop/Muhammad_Hafeez_Backups && mkdir $HOME/Desktop/Muhammad_Hafeez_Backups/tmp

echo -n "Please enter the path of the directory that you want to backup: "
read backupdir

if [ -d "$backupdir" ]; then
        echo "The directory path exists"
        echo -e "\n"

else
        echo -e "Directory does not Exist"
        echo -e "Please Re-enter the path again"
        backup
	echo -e "\n"
fi

echo -n "Please enter the name for backup folder: "
read backupname

TS=$(date +"%F")

chkbackup=`ls $HOME/Desktop/Muhammad_Hafeez_Backups/ | grep "$backupname"-"$TS"`

if [ ! $chkbackup ]
then
        $TS

        cp -a $backupdir $HOME/Desktop/Muhammad_Hafeez_Backups/tmp
        tar -czvf "$backupname"-"$TS".tgz $HOME/Desktop/Muhammad_Hafeez_Backups/tmp
        mv "$backupname"-"$TS".tgz $HOME/Desktop/Muhammad_Hafeez_Backups
        rm -r $HOME/Desktop/Muhammad_Hafeez_Backups/tmp
        echo `clear`
else
        echo -e "Something went wrong"
        echo -e "Please speak to your supervisor for additional details"

fi
        echo -e "\n"
        echo -e "Backup Complete"
        echo -e "The file will be located in $HOME/Desktop/mainBackups as "$backupname"-"$TS".tgz"
        echo -e "\n"
        echo -n "Would you like to backup another directory (y/n): "
        read input
        if [ "$input" == "y" ]
        then
                backup
        elif [ "$input" == "n" ]
        then
		echo -n `clear`
		exec ./Muhammad_Hafeez_IT_240_Project.txt
        else
                echo `clear`
                exit 1
fi
}

function backupwarning(){

echo "This script is going to ask a user to input the path of direcotry that he/she wants to backup."
echo -e "\n"
echo "It will ask the user for backup name and add time stamp to that folder so it will be unique everytime."
echo -e "\n"
echo -n "Do you wish to continue (y/n): "
read backupanswer
echo -e "\n"

if [ "$backupanswer" == "y" ]
then
        backup
        echo `clear`

elif [ "$backupanswer" == "n" ]
then
	echo -n `clear`
	exec ./Muhammad_Hafeez_IT_240_Project.txt

fi

}

while true 
do
clear

echo "##########################################"
echo "Muhammad U. Hafeez"
echo "##########################################"
echo "IT 240 - 452"
echo "##########################################"
echo "SystemAdmin Helper Program"
echo "##########################################"
echo "Please chmod +x <filename> for all the	"
echo "functions to work properly		"
echo "##########################################"

echo "Enter 1 to list users."
echo "Enter 2 to get IPV4/IPV6/WAN info"
echo "Enter 3 to get start monitoring Memory/CPU/DISK space."
echo "Enter 4 for calculator."
echo "Enter 5 to create/delete user and add/delete them from a group."
echo "Enter 6 to backup directory."
echo "Enter q to exit the menu."

echo -e "\n"
echo -n "Enter your selection: "
read result
echo -e "\n"

case "$result" in

1) who
   uptime ;;

2) lan_wan_ip;;

3) diskwarning;;

4) calculator;;

5) add_delete;;

6) backupwarning;;

q) exit ;;


esac
echo -e "\n"
echo -n "Enter return to continue with the script "
read input
done
