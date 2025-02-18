#!/bin/bash

set -o nounset \
    -o errexit \
    -o verbose

# See what is in each keystore and truststore
for i in confluent-registry client
do
        echo "------------------------------- $i keystore -------------------------------"
	keytool -list -v -keystore $i.keystore.jks -storepass mypassword | grep -e Alias -e Entry
        echo "------------------------------- $i truststore -------------------------------"
	keytool -list -v -keystore $i.truststore.jks -storepass mypassword | grep -e Alias -e Entry
done
