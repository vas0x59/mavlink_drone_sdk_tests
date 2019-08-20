#!/bin/bash

host="raspberrypi.local"

# read -sp 'password: ' passvar
echo ""

passvar=$(cat raspi_pass.txt)

lib_to_deploy=$(cat deploy_conf/lib_to_deploy.txt)
bin_to_deploy=$(cat deploy_conf/bin_to_deploy.txt)
scripts_to_deploy=$(cat deploy_conf/scripts_to_deploy.txt)

echo "lib: $lib_to_deploy"
echo "bin: $bin_to_deploy"
echo "script: $scripts_to_deploy"

for var in $(ls ./drone_scripts --color=never)
do 
    # echo "$var"
    scripts_to_deploy="$scripts_to_deploy ./drone_scripts/$var"
    # sshpass -p "$passvar" scp "drone_scripts/$var" pi@$host:
done

# to_deploy="$lib_to_deploy $bin_to_deploy $scripts_to_deploy"

sshpass -p "$passvar" scp $lib_to_deploy pi@$host:lib
sshpass -p "$passvar" scp $bin_to_deploy pi@$host:bin
sshpass -p "$passvar" scp $scripts_to_deploy pi@$host:
