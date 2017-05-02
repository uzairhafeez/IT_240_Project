# IT_240_Project

1.	List users & Runtime
This option lists the currently logged in user/s and tells you how long the system has been running for individual users. 

2.	Get IPV4/IPV6/WAN information
This option displays networking information such as WAN ip address, loopback ip address, IPV4 address information such as ip address, MAC address, Net-mask, and broadcast ip address. It also lists IPV6 address and prefix. All this information is sorted by using (awk) command which processes the rows and columns. 

3.	Stress test to monitor Memory/CPU/DISK
After acknowledging the warning message, this script is going to start a stress test which will last for 30 seconds. It is going to monitor Memory, Disk, CPU usage and once the time is up it will stop and the system administrator will be able to see the results.

4.	Calculator
This is a basic calculator which lists options for a user to decide if they want to add, subtract, multiply, or divide. It will ask the user to the enter the first and second number and will do the calculation. The main reason for this program so that if system administrator is running this program on the server end with no GUI, it will be helpful to do basic calculation.

5.	Create/Delete user and Add/Delete them from a group.
Warning = For this script, the system administrator needs to be in root to add or delete user from a group. With that in CentOS, I had issues trying to create a new user so I used Ubuntu 16.04 to run this part of the script.
The first function asks a user if they want to add or delete a user. Based on the user selection, it will run either the add function or delete function.
  Here is an example of script asking a user if they want to add or delete a user. The user went with adding a new user. Furthermore, it will present the user with a warning message that they need to be root to add a user. If yes, the script will continue and ask for new user information and also ask for a password. So here we can see, the new username is muh3 and it was added to group name muh3. Furthermore, if the group name does not exist, it will let the administrator know it they want to create a new group or enter an another existing group and based on the selection, it will continue with the script. 
  Once the user has been created and added to a group the function will ask if you want to add another user. If yes, it will re-run the function again or if no then it will present the user with a successful message.
  On the other end, if you go with deleting a user then the main function will run a delete user function where is will ask a user for username and in which group name the user is located. Once the information is provided, the script will delete that user from the group. Finally, it will ask the user if they want to delete another user. If the response is no, then it will exit from the script. 

6.	 Backup a directory.
This script is going to ask a user to input the path of a directory that he/she wants to backup. Once the user input the path, the function checks if the path is good or not. If the path is bad, it will echo out bad path message and ask the user to re-enter the path. Once the path is good it will continue and create a directory named “Muhammad_Hafeez_Backups” on to user’s desktop and also create a “tmp” folder inside of the main folder. Furthermore, it will ask the user to name the backup folder and then it will copy all the files and folders from the path and zip them with the extension” tgz”. It will also tell the user where the file is located and how the name looks like. Finally, the script will present the user with a message if they want to back up another directory.

7.	Exit
The script is set only when you enter q and hit the return key; it will exit the program and exit the script. 
