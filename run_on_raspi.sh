host="raspberrypi.local"

passvar=$(cat raspi_pass.txt)

# sshpass -p "$passvar" ssh pi@$host 'sudo bash -s' <<< "export LD_LIBRARY_PATH=/home/pi/lib && /home/pi/run_prog.sh $1 $2"
sshpass -p "$passvar" ssh -t pi@$host "/home/pi/run_prog.sh $1 $2"