#!/bin/bash

./truffleChange.sh
./pubKeyScript.sh

cd /home/testcases/files
rpcport=$(cat rpcport)
ip=$(cat ip)

curl -X POST --data '{"jsonrpc":"2.0","method":"eth_accounts","params":[],"id":83}' ${ip}:${rpcport} > resultAccts.json
cat resultAccts.json | jq '.result' > output.txt
sed '1d;$d' output.txt > output1.txt
sed 's/ //g' output1.txt > output2.txt
address=$(cat output2.txt)

curl -X POST --data '{"jsonrpc":"2.0","method":"personal_unlockAccount","params":['"$address"', "", 0],"id":1}' ${ip}:${rpcport} > unlock.json

cd /home/testcases/smart-contracts
npm install colors
truffle migrate --reset 
printf "\e[38;5;165mPrivate contracts deployed successfully!\033[0m\n"
truffle test
printf "\e[38;5;202mTruffle tests executed successfully!\033[0m\n"
