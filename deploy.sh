#!/bin/bash

host="raspberrypi.local"
read -sp 'password: ' passvar
echo ""
lib_to_deploy=$(cat lib_to_deploy.txt)
bin_to_deploy=$(cat bin_to_deploy.txt)
echo "lib: $lib_to_deploy"
echo "bin: $bin_to_deploy"

for var in $lib_to_deploy
do 
    echo "$var"
    sshpass -p "$passvar" scp "$var" pi@$host:lib
done

for var in $bin_to_deploy
do 
    echo "$var"
    sshpass -p "$passvar" scp "$var" pi@$host:bin
done