#!/bin/bash

docker run -it -v $(pwd):/home -w /home/testcases syneblock/cicd:quorum-maker-testsuite

#Fetch active nodes count
curl http://$ip:$nodemport/activeNodes > files/activeNodes.json
nodecount=$(jq '.nodeCount' files/activeNodes.json) 
cd ..

#Run test scripts based on the node count
if [ $nodecount!=1 ];
 then
   ./run_public_test.sh
   ./run_private_test.sh
else
 ./run_public_test.sh
fi


#!/bin/bash

cd testcases
./truffleChange.sh
ip=$(cat files/ip)
nodemport=$(cat files/nodeManagerPort)

#Fetch active nodes count
curl http://$ip:$nodemport/activeNodes > files/activeNodes.json
nodecount=$(jq '.nodeCount' files/activeNodes.json) 
cd ..

#Run test scripts based on the node count
if [ $nodecount!=1 ];
 then

#Spin up the truffle docker image & mount the truffle test scripts inside docker 
printf "\033[0;33mPublic deployment using truffle is taking place, alongwith running the testcases\033[0m\n"
docker run -it -v $(pwd):/home  -w /home/testcases syneblock/cicd:quorum-maker-testsuite ./run_public_test.sh

printf "\e[92mPrivate deployment using truffle is taking place, alongwith running the testcases\033[0m\n"
docker run -it -v $(pwd):/home  -w /home/testcases syneblock/cicd:quorum-maker-testsuite ./run_private_test.sh

else
printf "\033[0;33mPublic deployment using truffle is taking place, alongwith running the testcases\033[0m\n"
docker run -it -v $(pwd):/home  -w /home/testcases syneblock/cicd:quorum-maker-testsuite ./run_public_test.sh
fi
