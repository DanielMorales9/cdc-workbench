#!/bin/bash
set -ex

# Render the application.properties file using envsubst
pushd "${DEBEZIUM_CONFIG_DIR}"
envsubst < application.properties.template > application.properties
popd

# Start the client
./run.sh