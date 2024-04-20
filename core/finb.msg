#!/bin/bash

if [ $1 == "info" ]
then
	echo -e "[\e[32mInfo\e[0m] $2"
elif [ $1 == "warning" ]
then
	echo -e "[\e[33mWarning\e[0m] $2"
elif [ $1 == "error" ]
then
	echo -e "[\e[31mError\e[0m] $2"
else
	echo "invalid message type"
fi