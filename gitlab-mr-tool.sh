#!/bin/bash

### Script Desc ###
#
# Desc: Gitlab Merge Request tool automation using REST API
#
# Version: 0.0.1 - 18/11/2021
#
### EOH ###

SERVER="localhost:4000"
PROJECT_ID="5"
#PROJ_TOKEN="Lbf-zy42eSUFCa5DeXiH"
PROJ_TOKEN="Ef58KsqAWmj-S21vTye-"
C_POST="curl -s -F private_token=${PROJ_TOKEN} -X POST http://${SERVER}/api/v4"
C_GET="curl -s -F private_token=${PROJ_TOKEN} -X GET http://${SERVER}/api/v4"
C_PUT="curl -s -F private_token=${PROJ_TOKEN} -X PUT http://${SERVER}/api/v4"

##### ========== Colors table ========== #####
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White
##### ========== EOT ========== #####

echo -e "${BGreen}PHASE 1: Create a new MR${Color_Off}"
echo "Enther the source branch name:"
read SRC_BRA
echo "Enther the destination branch name:"
read DST_BRA
echo "Enther the MR title:"
read MR_TITLE

#echo $C_POST

#echo ${C_POST}/projects/${PROJECT_ID}/merge_requests\?id\=${PROJECT_ID}\&source_branch\=${SRC_BRA}\&target_branch\=${DST_BRA}\&title\=${MR_TITLE}
${C_POST}/projects/${PROJECT_ID}/merge_requests\?id\=${PROJECT_ID}\&source_branch\=${SRC_BRA}\&target_branch\=${DST_BRA}\&title\=${MR_TITLE}
echo "Press ENTER to issue next phase"
read nul

echo -e "${BGreen}PHASE 2: Check all MRs for this project${Color_Off}"
${C_GET}/projects/${PROJECT_ID}/merge_requests\?id\=${PROJECT_ID} | jq
echo "Press ENTER to issue next phase"
read nul

echo -e "${BGreen}PHASE 3: Check opened MR${Color_Off}"
echo "Enter the MR ID:"
read MR_ID
${C_GET}/projects/${PROJECT_ID}/merge_requests/${MR_ID} | jq
echo "Press ENTER to issue next phase"
read nul

echo -e "${BGreen}PHASE 4: Approve the MR${Color_Off}"
echo "Enter the MR ID:"
read MR_ID
#echo ${C_POST}/projects/${PROJECT_ID}/merge_requests/${MR_ID}/approve #| jq
${C_POST}/projects/${PROJECT_ID}/merge_requests/${MR_ID}/approve | jq
echo "Press ENTER to issue next phase"
read nul

echo -e "${BGreen}PHASE 5: Accept the merge from the MR${Color_Off}"
echo "Enter the MR ID:"
read MR_ID
#echo ${C_PUT}/projects/${PROJECT_ID}/merge_requests/${MR_ID}/merge #| jq
${C_PUT}/projects/${PROJECT_ID}/merge_requests/${MR_ID}/merge | jq
echo "Press ENTER to issue next phase"
read nul

echo -e "${BICyan}MR process performed successfully. HOORAY!!! \o/${Color_Off}"
sleep 10
