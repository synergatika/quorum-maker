#!/bin/bash

cd /home/testcases/files/
nodemPort=$(cat nodeManagerPort)
ip=$(cat ip)
curl http://$ip:$nodemPort/getNodeList > getNodeList.json

#Public keys are put into an array
echo "$x" | jq -r '.[]|"\(.publicKey)"' getNodeList.json > orig-data-filePubKey

readarray pubKey < orig-data-filePubKey
pubKeyCount=${#pubKey[@]}
#echo "$pubKeyCount"

#nodeNames are put into an array
echo "$x" | jq -r '.[]|"\(.nodeName)"' getNodeList.json > orig-data-fileNodeName
readarray nodeName < orig-data-fileNodeName
nodeNameCount=${#nodeName[@]}
#echo "$nodeNameCount"

#Public keys are put into an array
echo "$x" | jq -r '.[]|"\(.self)"' getNodeList.json > orig-data-self
readarray self < orig-data-self
selfCount=${#self[@]}
echo "Printing self count"
echo "$selfCount"

for ((i=0; i<=pubKeyCount; i++))
do 
selfvalue=$(echo "${self[i]}" | tr -d '\n')

if [ "$selfvalue" == "false" ]
  then
	temp=${pubKey[i]//$'\n'/}
	pvt+='"'${temp}'"',
 fi
done
 echo $pvt | sed s'/.$//' > ../propertiesTemplates/pvt.txt

cd /home/testcases/propertiesTemplates
cp private_deploy_contracts_template 2_deploy_contracts_data.js

infile=$(cat pvt.txt)
echo $infile

line_no=$(grep -n "privateFor:" 2_deploy_contracts_data.js | cut -d : -f 1)
sed -i.bak '/privateFor:/d' 2_deploy_contracts_data.js
sed -i.bak "${line_no}i\
  privateFor: [$infile]" 2_deploy_contracts_data.js

cp 2_deploy_contracts_data.js ../smart-contracts/migrations/.
