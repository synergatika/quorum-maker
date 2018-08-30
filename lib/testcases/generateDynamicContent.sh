#!/bin/bash

#Script that prepares the private truffle test script dynamically based on the network being set
cd /home/testcases/propertiesTemplates
cp testPrivateTemplate testPrivate.js
cp nodeTemplateFinal nodeFinal
cp nodeTemplate nodeOthers
cp nodeTemplateLast nodeLast
cp testCaseTemplate testCase.js
cd ..

activeNodes=$(cat files/activeNodes.json)
nodecount=$(jq '.nodeCount' files/activeNodes.json)

readarray pubKeys < files/orig-data-filePubKey
grep -n "publicKey:" propertiesTemplates/nodeFinal | cut -d : -f 1 > files/line_nos_final
readarray line_nos_final < files/line_nos_final
grep -n "publicKey:" propertiesTemplates/nodeOthers | cut -d : -f 1 > files/line_nos
readarray line_nos < files/line_nos
linecount=${#line_nos[@]}

grep -n "privateFor:" propertiesTemplates/testCaseTemplate | cut -d : -f 1 > files/testcase_lineno
testcase_lineno=$(cat files/testcase_lineno)

readarray nodeName < files/orig-data-fileNodeName
readarray self < files/orig-data-self 

#Prepares array of node objects based on the number of active node count in the network
for (( i=0; i < $nodecount; i++ ))
do
   num=$((nodecount-1))
 
nodeValue=$(echo "${nodeName[i]}" | tr -d '\n')
nodeValue=$(echo "$nodeValue" | tr -d ' ')

 selfvalue=$(echo "${self[i]}" | tr -d '\n')
  if [ "$selfvalue" = "true" ]; then
   var=${line_nos_final[0]}
   var="$(echo "$var" | sed -e 's/[[:space:]]*$//')"
   var=${var}
   pubKey=`echo "'"${pubKeys[i]}"'"`
   pubKey=$(echo "$pubKey" | tr -d ' ')
     sed -i "s/node:/$nodeValue:/g" propertiesTemplates/nodeFinal
   sed -e "$var"'d' propertiesTemplates/nodeFinal > files/nodeFinalTemp
   sed -i.bak "${var}i\
   publicKey: ${pubKey}" files/nodeFinalTemp 
   cat files/nodeFinalTemp > propertiesTemplates/nodeFinal
   
   echo $nodeValue > files/self_node_value
else 
   cp propertiesTemplates/nodeTemplate propertiesTemplates/nodeOthers
   var=${line_nos[0]}
   var="$(echo "$var" | sed -e 's/[[:space:]]*$//')"
   var=${var}
   pubKey=`echo "'"${pubKeys[i]}"'"`
   pubKey=$(echo "$pubKey" | tr -d ' ')
   sed -i "s/node:/$nodeValue:/g" propertiesTemplates/nodeOthers
   sed -e "$var"'d' propertiesTemplates/nodeOthers > files/nodeOthersTemp
   sed -i.bak "${var}i\
   publicKey: ${pubKey}" files/nodeOthersTemp 
   cat files/nodeOthersTemp >> propertiesTemplates/nodeFinal
 fi
done

var=$(cat propertiesTemplates/nodeFinal)
sed -i '10d' propertiesTemplates/testPrivate.js
ex -sc "10i|$var" -cx propertiesTemplates/testPrivate.js

first_line=$(head -n 1 propertiesTemplates/testCase.js)
self_node_name=$(cat files/self_node_value)
sed -i -e "s/nodeName1/${self_node_name}/g" propertiesTemplates/testCase.js

#Change the node name
for (( i=0; i < $nodecount; i++ ))
do
  selfvalue=$(echo "${self[i]}" | tr -d '\n')
  if [[ "$selfvalue" = "false" ]]; then
  nodeValue=$(echo "${nodeName[i]}" | tr -d '\n')
  nodeValue=$(echo "$nodeValue" | tr -d ' ')
  if [ $nodecount > 2  ]; then
   sed -e "$testcase_lineno"'d' propertiesTemplates/testCase.js > files/testCaseTemp.js
   sed -i.bak "${testcase_lineno}i\
     privateFor: [nodes.$nodeValue.publicKey]" files/testCaseTemp.js 
   sed -i -e "s/nodeName2/${nodeValue}/g" files/testCaseTemp.js
   cat files/testCaseTemp.js >> propertiesTemplates/testPrivate.js
  fi
  fi
done

cat propertiesTemplates/bracket >> propertiesTemplates/testPrivate.js
cp propertiesTemplates/testPrivate.js smart-contracts/test/.
   


