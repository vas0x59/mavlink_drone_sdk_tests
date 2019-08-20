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
program="$1"

if [ "$ar" = "x86_64" ]
then
LCOLOR=$LBLUE
else 
if [ "$ar" = "arm" ]
then
LCOLOR=$LGREEN
else
LCOLOR=$ORANGE
fi
fi

logo=" 
 MMMM          
 MMMMM        MM                  ll     i             k         
 MMM MM      MMM                   ll                  k    kk        $LCOLOR@@@@@@@@     @@@@@@      @       @$NC
 MMM  MM    MMMM                    l    i  n          k  k          $LCOLOR@            @      @    @     @@$NC
 MMM   MM  MM MM   aaaaa   v     v  l    i  nnnnnnn    kk           $LCOLOR@            @       @   @   @@$NC
 MMM    MMMM  MM        a  v     v  l    i  n      n   kk            $LCOLOR@@@@@@     @       @   @ @  $NC
 MMM          MM   aaaaaa  v     v  l    i  n      n   k kk                $LCOLOR@   @       @   @@  @@ $NC
 MMM          MM  a     a   v   v   ll   i  n      n   k   kk             $LCOLOR@   @      @    @      @@$NC
              MM  aaaaaa      v      ll  i  n      n   k     kk   $LCOLOR@@@@@@@@   @@@@@@@     @         @$NC
 
 on $LCOLOR$ar$NC
 Version $(./get_version.sh)
                                                                                     by Vasily Yuryev
                                                                                                 2019
"
echo -e "$logo"

echo "$(uname -a)"
echo ""
./log.sh INFO runner START
# ./log.sh INFO runner Starting mavlink-router
./log.sh INFO runner "Starting Program"
if [ "$ar" = "x86_64" ]
then
./../build/$program
else
/home/pi/bin/$program
fi