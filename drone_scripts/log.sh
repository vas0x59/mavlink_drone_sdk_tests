#!/bin/bash

GREEN='\033[0;32m'
LGREEN='\033[1;32m'

ORANGE='\033[0;33m'
YELLOW='\033[1;33m'

RED='\033[0;31m'
LRED='\033[1;31m'

BLUE='\033[0;34m'
LBLUE='\033[1;34m'

PURPLE='\033[0;35m'
LPURPLE='\033[1;35m'

CYAN='\033[0;36m'
LCYAN='\033[1;36m'

NC='\033[0m'

COLOR=NC
LCOLOR=NC

if [ "$1" = "INFO" ]
then
    COLOR=$GREEN
    LCOLOR=$LGREEN
fi 
if [ "$1" = "ERROR" ]
then
    COLOR=$RED
    LCOLOR=$LRED
fi 
if [ "$1" = "WARN" ]
then
    COLOR=$ORANGE
    LCOLOR=$YELLOW
fi 

echo -e "$LCOLOR[${1}]$COLOR[$2]${NC}: ${3}${NC}"