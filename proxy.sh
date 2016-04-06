#AUTHOR: poke19962008
#!/bin/bash
rm -f log.txt	#Remove Previous Log File
fin=( "0" )

HEADER='\033[95m'
INFO='\033[94m'
SUCCESS='\033[92m'
WARNING='\033[93m'
FAIL='\033[91m'
ENDC='\033[0m'
BOLD='\033[1m'
UNDERLINE='\033[4m'
NC='\033[0m' # No Color

for i in {0..101}
do
	prxy="172.16.0.$i:8080"
	echo -e "Connecting: ${HEADER}$prxy${NC}"
	curl --proxy $prxy --max-time 1 --silent 74.125.224.72 --output "log.txt"

	if [[ -s log.txt ]]
	then
		echo -e "${SUCCESS}Success${NC}"   #Received Data
		fin=( ${fin[@]} $prxy )
		rm -f log.txt
		echo " "
	else
		echo -e "${FAIL}Failed${NC}"  #Not Received Data
	fi
done

echo "---------------------------------------------------------------"

unset fin[0]
if [[ ${#fin[@]} -ne 0 ]]
then
	echo "Open Proxy: "${#fin[@]}
	echo "IP: "${fin[@]}
else
	echo "Sorry no proxy server is open."
fi
