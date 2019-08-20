#!/bin/bash

# echo ""


# Mavlink SDK


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
ar_postfix=""

if [ "$ar" = "x86_64" ]
then
LCOLOR=$LBLUE
else 
if [ "$ar" = "armv7l" ]
then
LCOLOR=$LGREEN
ar_postfix=" : ${LGREEN}Raspberry${LRED} PI${NC}"
else
LCOLOR=$ORANGE
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
echo -e "$logo"

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
            ./log.sh INFO runner "Starting $program"
            echo ""
            ./../build/$program
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
            ./log.sh INFO runner "Starting $program"
            echo ""
            /home/pi/bin/$program
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