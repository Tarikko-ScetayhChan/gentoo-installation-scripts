#!/bin/bash

if [ $1 == "info" && $2 -ne "" ]
then
	echo -e "[\e[032mInfo\e[0m] $2"
elif [ $1 == "warning" && $2 -ne "" ]
then
	echo -e "[\e[033mWarning\e[0m] $2"
elif [ $1 == "error" && $2 -ne "" ]
then
	echo -e "[\e[031mError\e[0m] $2"
else
	if [ $2 == "" ]
	then
		echo "finb.core.msg: invalid message '$2'"
	else
		echo "finb.core.msg: invalid message type '$1'"
	fi
	exit 1
fi