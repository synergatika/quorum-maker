#!/bin/bash

#Spin up the truffle docker image & mount the truffle test scripts inside docker 
printf "\033[0;33mPublic deployment using truffle is taking place, alongwith running the testcases\033[0m\n"
docker run -it -v $(pwd):/home  -w /home/testcases syneblock/cicd:quorum-maker-testsuite ./run_public_test.sh

printf "\e[92mPrivate deployment using truffle is taking place, alongwith running the testcases\033[0m\n"
docker run -it -v $(pwd):/home  -w /home/testcases syneblock/cicd:quorum-maker-testsuite ./run_private_test.sh
