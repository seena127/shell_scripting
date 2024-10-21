#!/bin/bash
#
#Author: Bhaskara sreenivasa sarma
#Date:20-10-2024
#Notes: User management based script
#

check(){
        if [ "$EUID" -ne 0 ]; then
                echo "Please do execute the script as root user to execute"
                exit 1
fi
if [ "$#" -ne 3 ]; then
        echo "please execute the scriprt as sudo ./user_mgmt.sh user_name user_group yes|no "
        echo "yes parameter for creation, no for deletion"
        exit 1
fi
}
create_group(){
        local group_name="$2"
        if getent group "$group_name" &> /dev/null 2&1; then
                echo "group name $2 already exists"
                exit 1
        else
                groupadd "$group_name"
        fi
}
create_user(){
        local username="$1"
        local grpname="$q"
        local password="Password@123"
        if id "$username" &> /dev/null ; then
                echo "$username already exists"
                exit 1
        else
                adduser --gecos "" --disabled-password "$username"
                echo "$username:$password" | chpasswd
                passwd -e "$username"
                echo "$username created with mentioned password i.e $password"
                usermod -aG "$grpname" "$username"
                groups "$username"
        fi
}
delete_user(){
        local username="$1"

        if id "$username" &> /dev/null; then
                userdel -r "$username"
                echo "$username has been deleted"
        else
                echo "$username doesn't exist hence no deletion"
                exit 1
        fi
}
delete_group(){
        local grpname="$2"
        if getent group "$grpname" &> /dev/null ; then
                groupdel "$grpname"
                echo "$grpname has been deleted"
        else
                echo "$grpname doesn't exits, so can't be deleted"
                exit 1
        fi
}
list_user(){
        echo "username with directory:"
        cat /etc/passwd | awk -F: '{ print $1, $6}'
        cat /etc/group
}
check "$@"

case "$3" in
        yes)

                create_group "$@"
                create_user "$@"
                list_user
                ;;
        no)

                delete_user "$1"
                delete_group "$2"
                list_user
                ;;
        *)
                echo "Invalid option. use 'yes' or 'no' option for creation and deletion"
                exit 1

                ;;
esac
