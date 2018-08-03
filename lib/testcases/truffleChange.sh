#!/bin/bash


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

cd /home/testcases/propertiesTemplates
cp truffleTemplate truffle.js

sed -i 's/ipaddr/'${ip}'/' truffle.js
sed -i 's/8000/'${port}'/' truffle.js

cp truffle.js ../smart-contracts/.

cd ..
