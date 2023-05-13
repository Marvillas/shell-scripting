#!/bin/bash

# This script creates an account on the local system
# You will be prompted for the account name and password.

# Ask for the user name.
read -p 'Enter the username to create: ' USER_NAME

# Ask for the real names
read -p 'Enter the name of the person who this account if for: ' COMMENT

# Ask for the password
read -p 'Enter the password to use for the account: ' PASSWORD

# Ask to check if the name of the user exist
if [[ "$(id -un ${USER_NAME})" = "${USER_NAME}" ]]
then
	userdel -f ${USER_NAME}
else
	echo 'It does not exist, You can go ahead and create the account'
fi
# Create the user.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Set the password for the user.
echo -e "${PASSWORD}\n${PASSWORD}" | passwd ${USER_NAME}

# FOrce the password change on the first login.
passwd -e ${USER_NAME}
