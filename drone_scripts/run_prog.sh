#!/bin/sh

# echo ""


# Mavlink SDK
# echo $$


GREEN='\033[0;32m'
LGREEN='\033[1;32m'

ORANGE='\033[0;33m'

RED='\033[0;31m'
LRED='\033[1;31m'

BLUE='\033[0;34m'
LBLUE='\033[1;34m'

PURPLE='\033[0;35m'
LPURPLE='\033[1;35m'

CYAN='\033[0;36m'
LCYAN='\033[1;36m'

NC='\033[0m'


ar=$(arch)
# ar="x86"
program="$1"
ip_port="127.0.0.1:14540"

ar_postfix=""

if [ "$ar" = "x86_64" ]
then
    LCOLOR=$LBLUE
else 
    if [ "$ar" = "armv7l" ]
    then
        LCOLOR=$LGREEN
        ar_postfix=" : ${LGREEN}Raspberry${LRED} PI${NC}"
        export LD_LIBRARY_PATH=/home/pi/lib 
    else
        if [ "$ar" = "armv6l" ]
        then
            LCOLOR=$LPURPLE
            ar_postfix=" : ${LPURPLE}Raspberry${LRED} PI Zero${NC}"
            export LD_LIBRARY_PATH=/home/pi/lib 
        else
        LCOLOR=$ORANGE
        fi
    fi
fi

logo=" 
 ##          
 ##M          ##                  ##     #             #         
 ## #        ###                   L#                  #    ##        $LCOLOR@@@@@@@@     @@@@@@      @       @$NC
 ##  #      # ##                    #    I  #          #  #          $LCOLOR@            @      @    @     @@$NC
 M#   #    #  M#   #####   #     V  #    I  #######    #k           $LCOLOR@            @       @   @   @@$NC
 ##    #  #   ##        #  #     #  #    #  N      #   ##            $LCOLOR@@@@@@     @       @   @@@  $NC
 ##     M#    ##   ##A###  V     #  #    #  #      #   # ##                $LCOLOR@   @       @   @   @@ $NC
 ##           #M  #     #   #   #   ##   #  #      #   #   ##             $LCOLOR@   @      @    @      @@$NC
              ##  #A####      #      #L  #  #      N   #     #k   $LCOLOR@@@@@@@@   @@@@@@@     @         @$NC
 
 on $LCOLOR$ar$NC$ar_postfix
 Version $(./get_version.sh)
                                                                                     by Vasily Yuryev
                                                                                                 2019
"
echo "$logo"

echo "$(uname -a)"
echo ""
# ./log.sh INFO runner START
# ./log.sh INFO runner Starting mavlink-router

# echo ""

mrouter_pid=-1
mrouter_endpoint="127.0.0.1:14540"



if [ "$2" != "0" ] 
then
    if [ "$2" != "" ]
    then
        mrouter_endpoint="$2"
    fi

    ./log.sh INFO runner "Starting mavlink-routerd [$mrouter_endpoint]"

    ./start_router.sh $mrouter_endpoint & mrouter_pid=$!
    # mrouter_pid=$1
    sleep 1
fi

# echo "mavlink-routerd_pid: $mrouter_pid"



if [ "$ar" = "x86_64" ]
then
    if [ -f "./../build/$program" ]
    then
        if [ -x "./../build/$program" ]
        then
            ip_port=$(cat ./../configs/$program.txt)
            ./log.sh INFO runner "Starting $program"
            echo ""
            ./../build/$program $ip_port
        else
            ./log.sh ERROR runner "File: $program - is not executable"
        fi
    else
        ./log.sh ERROR runner "File: $program - not found"
    fi
else
    if [ -f "/home/pi/bin/$program" ]
    then
        if [ -x "/home/pi/bin/$program" ]
        then
            ip_port=$(cat /home/pi/configs/$program.txt)
            ./log.sh INFO runner "Starting $program"
            echo ""
            /home/pi/bin/$program $ip_port
            # echo $!
        else
            ./log.sh ERROR runner "File: $program - is not executable"
        fi
    else
        ./log.sh ERROR runner "File: $program - not found"
    fi
fi

if [ "$2" != "0" ] 
then
./log.sh WARN runner "Stopping mavlink-routerd [$mrouter_endpoint]"
sleep 0.5
# kill -s SIGKILL $mrouter_pid
pkill mavlink-routerd
fi