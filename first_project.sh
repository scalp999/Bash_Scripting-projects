#Goal:
#The goal of this exercise is to create a shell script that adds users to the same Linux system as the
#script is executed on.
#############The script:

#● Enforces that it will be executed with superuser (root) privileges. If the script is not executed with
#superuser privileges it will not attempt to create a user and returns an exit status of 1.
#● Provides a usage statement much like you would ﬁnd in a man page if the user does not
#supply an account name on the command line and returns an exit status of 1.
#● Uses the ﬁrst argument provided on the command line as the username for the account. Any
#remaining arguments on the command line will be treated as the comment for the account.
#http://www.LinuxTrainingAcademy.com● Automatically generates a password for the new account.
#● Informs the user if the account was not able to be created for some reason. If the account is
#not created, the script is to return an exit status of 1.
#● Displays the username, password, and host where the account was created. This way the
#help desk staﬀ can copy the output of the script in order to easily deliver the information to
#the new account holder.

# Script must be executed with SU priveleges only. Return exit status 1 if executed not under ROOT 

ROOT_UID_TEST=0
if [[ ${UID} -ne $ROOT_UID_TEST ]]
then
	echo "Script must be executed only under ROOT priveleges "
exit 1
fi

#Prompts the person who executed the script to enter the username (login),
#the name for the person who will be using the account, 
#and the initial password for the account.

read -p "Enter you account name: " userName
read -p "Enter your first and last name: " realName
read -p "Enter your password: " passW

#Creates a new user on the local system with the input provided by the user.

useradd -c "${realName}" -m -d /home/osboxes/LinPR2022/Lesson1/localUsers/"${userName}" $userName

#echo ${passW} | passwd ${userName} -this option doesnt work properly on my ubuntu build

passwd ${userName}

#Informs the user, if the account was not able to be created for some reason.
#If the account is not created, the script is to return an exit status of 1

exit_status="${?}"
if [[ "${exit_status}" -ne 0 ]]
then
	echo "User account can not be created"
exit 1
fi

#Force user to change password after first login
passwd -e ${userName}

#Displays the username, password, and host where the account was created. 
#This way the help desk staﬀ can copy the output of the script in order 
#to easily deliver the information to the new account holder.

echo "The account was created under" 
echo "${realName}"
echo
echo "Account login is: "
echo "${userName}"
echo
echo "Account password is: "
echo "${passW} "
echo
echo "Users home directory is:"
eval echo ~$userName
# echo ${HOSTNAME} is another option to check