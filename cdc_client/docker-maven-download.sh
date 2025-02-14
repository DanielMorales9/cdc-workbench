#!/bin/bash

# Download maven dependencies
set -ex

# If there's not maven repository url set externally,
# default to the ones below
MAVEN_REPO_CENTRAL=${MAVEN_REPO_CENTRAL:-"https://repo1.maven.org/maven2"}
MAVEN_REPO_CONFLUENT=${MAVEN_REPO_CONFLUENT:-"https://packages.confluent.io/maven"}
MAVEN_DEP_DESTINATION=${MAVEN_DEP_DESTINATION}
DEBEZIUM_HOME=${DEBEZIUM_HOME}

maven_dep() {
    local REPO="$1"
    local GROUP="$2"
    local PACKAGE="$3"
    local VERSION="$4"
    local FILE="$5"

    DOWNLOAD_FILE_TMP_PATH="/tmp/maven_dep/${PACKAGE}"
    DOWNLOAD_FILE="$DOWNLOAD_FILE_TMP_PATH/$FILE"
    CHECKSUM_FILE="$DOWNLOAD_FILE_TMP_PATH/$FILE.md5"
    test -d "$DOWNLOAD_FILE_TMP_PATH" || mkdir -p "$DOWNLOAD_FILE_TMP_PATH"

    URL="$REPO/$GROUP/$PACKAGE/$VERSION/$FILE"
    CHECKSUM_URL="$URL.md5"
    curl -sfSL -o "$DOWNLOAD_FILE" "$URL"
    curl -sfSL -o "$CHECKSUM_FILE" "$CHECKSUM_URL"

    MD5HASH=$( cat "$CHECKSUM_FILE" )
    echo "$MD5HASH  $DOWNLOAD_FILE" | md5sum -c -
}

maven_confluent_dep() {
    maven_dep "$MAVEN_REPO_CONFLUENT" "io/confluent" "$1" "$2" "$1-$2.jar"
    mv "$DOWNLOAD_FILE" "$MAVEN_DEP_DESTINATION"
}

maven_debezium_server() {
    maven_dep "$MAVEN_REPO_CENTRAL" "io/debezium" "debezium-server-dist" "$1" "debezium-server-dist-$1.tar.gz"
    tar -xzf "$DOWNLOAD_FILE" -C "${DEBEZIUM_HOME}" --strip-components 1
    rm -f "$DOWNLOAD_FILE"
    rm -f "$CHECKSUM_FILE"
}

maven_apicurio_registry() {
    maven_dep "$MAVEN_REPO_CENTRAL" "io/apicurio" "apicurio-registry-$1" "$2" "apicurio-registry-$1-$2.tar.gz"
    tar -xzf "$DOWNLOAD_FILE" -C "$MAVEN_DEP_DESTINATION"
    rm -f "$DOWNLOAD_FILE"
    rm -f "$CHECKSUM_FILE"
}

maven_central_deps() {
    maven_dep "$MAVEN_REPO_CENTRAL" "$1" "$2" "$3" "$2-$3.jar"
    mv "$DOWNLOAD_FILE" "$MAVEN_DEP_DESTINATION"
}

case $1 in
    "confluent" ) shift
            maven_confluent_dep "${@}"
            ;;
    "debezium-server" ) shift
            maven_debezium_server "${@}"
            ;;
    "apicurio" ) shift
            maven_apicurio_registry "${@}"
            ;;
    "central" ) shift
            maven_central_deps "${@}"
            ;;
esac