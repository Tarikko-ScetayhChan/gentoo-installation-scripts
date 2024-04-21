#!/bin/bash

if [ $1 == "info" ]
then
	echo -e "[\e[032mInfo\e[0m] $2"
elif [ $1 == "warning" ]
then
	echo -e "[\e[033mWarning\e[0m] $2"
elif [ $1 == "error" ]
then
	echo -e "[\e[031mError\e[0m] $2"
else
	echo "invalid message type"
fi