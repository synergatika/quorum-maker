#!/bin/bash

#Spin up the truffle docker image & mount the truffle test scripts inside docker 
printf "\033[0;33mTruffle contract deployment & execution of truffle tests are about to begin...\033[0m\n"
docker run -it -v $(pwd):/home  -w /home/testcases syneblock/cicd:quorum-maker-testsuite ./truffleChange.sh
