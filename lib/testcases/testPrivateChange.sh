#!/bin/bash

cd /home/testcases/propertiesTemplates
cp testPrivateTemplate testPrivate.js

cd ..

readarray pubKeys < files/orig-data-filePubKey
grep -n "publicKey:" propertiesTemplates/testPrivate.js | cut -d : -f 1 > files/line_nos
readarray line_nos < files/line_nos
linecount=${#line_nos[@]}
echo "Line Count: "$linecount

for (( i=0; i < $linecount; i++ ))
do
 readarray self < files/orig-data-self
 selfvalue=$(echo "${self[i]}" | tr -d '\n')
 if [ "$selfvalue" = "true" ]; then
  var=${line_nos[0]}
 var="$(echo "$var" | sed -e 's/[[:space:]]*$//')"
 var=${var}
 pubKey=`echo "'"${pubKeys[0]}"'"`
 pubKey=$(echo "$pubKey" | tr -d ' ')
 sed -e "$var"'d' propertiesTemplates/testPrivate.js > propertiesTemplates/testPrivate1.js
 mv propertiesTemplates/testPrivate1.js propertiesTemplates/testPrivate.js
 sed -i.bak "${var}i\
   publicKey: ${pubKey}" propertiesTemplates/testPrivate.js
 fi
done

for (( i=0; i < $linecount; i++ ))
 do
 var=${line_nos[i]}
 echo $var
 var="$(echo "$var" | sed -e 's/[[:space:]]*$//')"
 var=${var}
 pubKey=`echo "'"${pubKeys[i]}"'"`
 pubKey=$(echo "$pubKey" | tr -d ' ')
 sed -e "$var"'d' propertiesTemplates/testPrivate.js > propertiesTemplates/testPrivate1.js
mv propertiesTemplates/testPrivate1.js propertiesTemplates/testPrivate.js
sed -i.bak "${var}i\
   publicKey: ${pubKey}" propertiesTemplates/testPrivate.js
done

cp -r propertiesTemplates/testPrivate.js smart-contracts/test/.
