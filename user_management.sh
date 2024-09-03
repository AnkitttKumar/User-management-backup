#creating user

create_user(){
	echo "Enter the username to create: "
	read username
	sudo useradd -m "$username"
	if [ $? -eq 0 ]; then
		echo "User $username has been created successfully!"
	else
	 	echo "Failed to create the user $username."
	fi
}

#delete the user

delete_user(){
	echo "enter the username to delete: "
	read username
	sudo userdel -r "$username"
	if [ $? -eq 0 ]; then
		echo "user $username deleted successfull"
	else
		echo "failed to delete user"
	fi
}

#listing users
list_user(){
	echo "List of users: "
	cut -d: -f1 /etc/passwd
}

#backup the home directory

backup_home(){
	echo "enter username whose home directry to backup"
	read username
	home_dir="/home/$username"
	backup_dir="/backup"
	if [ -d "$home_dir" ]; then
		sudo mkdir -p $backup_dir
		sudo tar -czf $backup_dir/{$username}_home_$(date +F%).tar.gz $home_dir
		if [ $? -eq 0 ]; then
			echo "home directory of $username has been backup successfully"
		else
			echo "failed to backup the directory"
		fi
	else
		echo "user $username doesn't exist or home directory not found"
	fi
}

#creating option to automate

while true; do
	echo "user management and backup systems"
	echo "1. create a user"
	echo "2. delete a user"
	echo "3. list the users"
	echo "4. backup user home directory"
	echo "5. exit"
	read -p "choose an operation to perform[1-5]: " option

	case $option in
		1) create_user ;;
		2) delete_user ;;
		3) list_user ;;
		4) backup_home ;;
		5) echo "exiting..."; exit 0;;
		*) echo "Invalid operation, please choose 1-5" ;;
	esac
done

