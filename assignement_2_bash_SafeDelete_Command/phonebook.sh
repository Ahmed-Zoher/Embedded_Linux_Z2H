#! /bin/bash
 
if [ -e ~/.phonebookDB.txt ]                                                       #check if database file exists
then
	#Do_Nothing
	echo
else
	touch ~/.phonebookDB.txt
	chmod 777 ~/.phonebookDB.txt	                                          #make a new database hidden file 
	echo "Contacts Details: " >> ~/.phonebookDB.txt
fi

case $1 in 
-i)     
	echo "" >> ~/.phonebookDB.txt
	echo "--------------------------------INSERT MODE----------------------------------------------"
	read -p "Please Insert Contact Name " Name
	grep "+$Name :" ~/.phonebookDB.txt > /dev/null
	if [ $? == 0 ]
	then
		echo "Contact already exists please delete it first "
		exit 1
	fi	
	read -p "Please Insert PhoneNumber " Phone
	while  [[ ! $Phone =~ ^[0-9]+$ ]]
	do
		echo 
		echo -n "Please enter digits ONLY, i.e. [0-9]" 
		echo 
		read -p "Please Insert PhoneNumbers " Phone
	done
	echo -n +$Name : " " >> ~/.phonebookDB.txt
	echo -n $Phone >> ~/.phonebookDB.txt
	flag=0
	while [ $flag == 0 ]                                                       #loop while user want to add new number
	do
		read -p "Do you want to insert another number [Y/N] " answer
		if [ $answer == "Y" ]
			then 	
			read -p "Please Insert PhoneNumber " Phone
			while [[ ! $Phone =~ ^[0-9]+$ ]]
			do
				echo 
				echo -n "Please enter digits ONLY, i.e. [0-9]" 
				echo 
				read -p "Please Insert PhoneNumbers " Phone		
			done
			read -p "Please Insert PhoneNumbers " Phone
			echo -n " - "$Phone >> ~/.phonebookDB.txt
		elif [ $answer == "N" ]
		then
			flag=1
		else
			echo 
			echo -n "incorrect input Select one of these options (Y) or (N)" 
			echo 
		fi 
	done
	echo
	echo "------------------------------END INSERT MODE----------------------------------------------" 
	echo "" ;;
-v)
	echo
	echo "--------------------------------VIEW ALL MODE----------------------------------------------"	
	cat ~/.phonebookDB.txt
	echo
	echo "--------------------------------END VIEW ALL MODE----------------------------------------------";;
-s)
	echo
	echo "--------------------------------SEARCH MODE----------------------------------------------"
	echo
	read -p "Please Insert Contact Name to search for " sName
	grep "+$sName :" ~/.phonebookDB.txt 
	if [ $? != 0 ]
	then 
		echo "Contact Not Found"
	fi
	echo
	echo "--------------------------------END SEARCH MODE----------------------------------------------";;
-e)
	echo
	echo "--------------------------------DELETE ALL MODE----------------------------------------------"
	echo "Contacts Details: " > ~/.phonebookDB.txt
	echo "" >> ~/.phonebookDB.txt
	echo
	echo "--------------------------------END DELETE ALL MODE----------------------------------------------";;
-d)
	echo
	echo "--------------------------------DELETE MODE----------------------------------------------"
	echo
	read -p "Please Insert Contact Name to delete " dName
	grep "+$dName :" ~/.phonebookDB.txt 
	if [ $? != 0 ]
	then 
		echo "Contact Not Found"
	fi
 	sed -i "/+$dName :/c\\" ~/.phonebookDB.txt
	echo
	echo "--------------------------------END DELETE MODE----------------------------------------------";;
*)    #information like man pages :)
	echo
	echo "NAME"
	echo "       phonebook.sh - PhoneBook Application"
	echo
	echo "SYNOPSIS"
	echo "       phonebook.sh [OPTIONS]..."
	echo
	echo "DESCRIPTION"
        echo "       Manage contacts with the ability to display, add and delete one or more contact."
	echo
	echo "       -i"
        echo "	      Insert a new contact name and number. " 
	echo
        echo "       -v"
        echo "	      View all saved contacts details."
	echo 
        echo "       -s"
        echo "	      Search by contact name." 
	echo
        echo "       -e"
        echo "	      Delete all Phonebook records." 
	echo
        echo "       -d"
        echo "	      Delete only one contact name."
	echo
	echo "AUTHOR"
	echo "       Developed by: Ahmed Zoher (ahmed.o.zoher@gmail.com)"
	echo ;;
esac
