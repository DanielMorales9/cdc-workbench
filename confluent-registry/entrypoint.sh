#!/bin/bash
set -ex

pushd "$SCHEMA_REGISTRY_HOME"

bin/schema-registry-start etc/schema-registry/schema-registry.properties

popd
