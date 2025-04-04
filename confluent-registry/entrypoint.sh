#!/bin/bash
set -e

pushd "$CONFLUENT_HOME"

bin/schema-registry-start /etc/schema-registry/schema-registry.properties

popd
