#!/bin/bash

# This script creates a new user account.

# Make sure the script is being executed with superuser privileges.
if [[ ${EUID} -ne 0 ]]
then
	echo 'This script must be run with superuser privileges.'
	exit 1
fi

# Get the username (login).
read -p 'Enter the username: ' USER_NAME
# Check if the username already exists.
if id ${USER_NAME} >/dev/null 2>&1; then
 echo "The username $username already exists."
 exit 1
fi
# Get the real name (contents for the description field).
read -p 'The real names of the user that account is for: ' COMMENT

# Get the password.
read -p 'Enter the password for the account: ' PASSWORD

# Create the user with the password.
useradd -m -c "${COMMENT}" ${USER_NAME}

# Check to see if the useradd command succeeded.
if if [[ "${?}" -ne 0 ]]
then
 echo "The user account ${USER_NAME} could not be created."
 exit 1
fi

#Set the password.
echo -e "${PASSWORD}\n${PASSWORD}" | passwd ${USER_NAME}
# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]] 
then
 echo "The password for the user account ${USER_NAME} could not be set."
 exit 1
fi

# Force password change on first login.
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.
echo "The user account ${USER_NAME} has been created successfully on this host ${HOSTNAME}."
echo "The username is ${USER_NAME}"
echo "The password is ${PASSWORD}."

exit 0
