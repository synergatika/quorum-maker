#!/bin/bash

#Script that makes changes to the truffle configurations based on the network being set
function readFromFile(){
var="$(grep -F -m 1 'RPC_PORT=' $1)"; var="${var#*=}"
port=$var
echo $port > testcases/files/rpcport

var="$(grep -F -m 1 'THIS_NODEMANAGER_PORT=' $1)"; var="${var#*=}"
nodeMPort=$var
echo $nodeMPort > testcases/files/nodeManagerPort

var="$(grep -F -m 1 'CURRENT_IP=' $1)"; var="${var#*=}"
ip=$var
echo $ip > testcases/files/ip
}

cd ..
readFromFile setup.conf

#Change truffle configuration file
cd /home/testcases/propertiesTemplates
cp truffleTemplate truffle.js

sed -i 's/ipaddr/'${ip}'/' truffle.js
sed -i 's/8000/'${port}'/' truffle.js

cp truffle.js ../smart-contracts/.
cd ..

#Fetch active nodes count
sleep 10
curl -s http://$ip:$nodeMPort/activeNodes > files/activeNodes.json
activeNodes=$(cat files/activeNodes.json)
nodecount=$(jq '.nodeCount' files/activeNodes.json) 

#Run test scripts based on the node count
if [ $nodecount -ne 1 ];
 then
   cd /home/testcases
   ./run_public_test.sh
   ./run_private_test.sh
else
  printf "\033[0;33mRunning only public truffle tests since there is only one node in the network\033[0m\n"
   ./run_public_test.sh
fi


