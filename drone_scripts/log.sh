

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

COLOR=NC

if [ "$1" = "INFO" ]
then
    COLOR=$GREEN
fi 
if [ "$1" = "ERROR" ]
then
    COLOR=$RED
fi 
if [ "$1" = "WARN" ]
then
    COLOR=$YELLOW
fi 

echo -e "$COLOR[${1}][$2]: ${3}${NC}"