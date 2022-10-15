#!/bin/bash
 
# This Script creat a new user on the local system.
# You will be prompted to enter the username (login), the person name, and a password
# The username, password, and host for the account will be displayed.

if (( UID != 0 ))
then
	echo 'Please run with sudo or as root.'
	exit 1
fi

# Get the username (login).

read -p ' Enter the username to create: ' USER_NAME

# Get the real name (contents for the description fileld).

read -p 'Enter the name of the person or application that will be using this account:' COMMENT

# Get the password

read -p 'Enter the password to use for the account:' PASSWORD

# Create the account

useradd -c "${COMMENT}" -m ${USER_NAME}

# Check if the useradd command succeeded.
# We don't want to tell the user that an acccount was created when it has't been.

if (( $? != 0 ))
then
	echo 'The account could not be created'
	exit 1
fi
 
# Set the password
# Check if it is Successful

echo "$USER_NAME:${PASSWORD}" | chpasswd

if (( $? != 0 ))
then
	echo 'The password for the account could not be set.'
	exit 1
fi

# Force password change on first login

passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.
echo
echo 'Username:'
echo "${USER_NAME}"
echo
echo 'password'
echo "${PASSWORD}"
echo
echo 'host:'
echo "${HOSTNAME}"
exit 0
