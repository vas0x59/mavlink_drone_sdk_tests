#!/bin/bash

host="raspberrypi.local"
read -sp 'password: ' passvar
echo ""
lib_to_deploy=$(cat deploy_conf/lib_to_deploy.txt)
bin_to_deploy=$(cat deploy_conf/bin_to_deploy.txt)
scripts_to_deploy=$(cat deploy_conf/scripts_to_deploy.txt)
echo "lib: $lib_to_deploy"
echo "bin: $bin_to_deploy"
echo "script: $scripts_to_deploy"

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

for var in $(ls ./drone_scripts --color=never)
do 
    echo "$var"
    sshpass -p "$passvar" scp "drone_scripts/$var" pi@$host:
done