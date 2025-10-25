#!/bin/bash

echo -en "\e[31;32m"
echo "* Hola, Ivette:"

echo -en "M'estimes? \e[31;33m"
read amor

amor=$(echo $amor | tr '[:upper:]' '[:lower:]')

while [[ $amor != x* && $amor != s* ]]; do
	echo -en "\e[31;32mNo m'estimes???? \e[31;33m"
	read amor
done

echo -e "\e[31;32mGràxies, jo més. :)"

echo -en "\e[31;0m"
