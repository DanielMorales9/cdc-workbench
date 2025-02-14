FROM eu.gcr.io/revolut-labs/revolut-java:17

ENV DEBEZIUM_VERSION=2.7.4.Final
ENV APICURIO_CONNECTOR_VERSION=2.6.1.Final
ENV CONFLUENT_DEPS_VERSION=7.7.0
ENV AVRO_VERSION=1.12.0
ENV GUAVA_VERSION=33.4.0-jre
ENV DEBEZIUM_HOME=/opt/debezium
ENV DEBEZIUM_CONFIG_DIR=${DEBEZIUM_HOME}/conf
ENV DEBEZIUM_LIB_DIR=${DEBEZIUM_HOME}/lib
ENV MAVEN_DEP_DESTINATION=${DEBEZIUM_LIB_DIR}

# prep for installation
RUN apt-get update && \
    apt-get -y install curl gettext

COPY docker-maven-download.sh /usr/local/bin/docker-maven-download

# install deps
RUN mkdir -p $DEBEZIUM_HOME && \
    docker-maven-download debezium-server ${DEBEZIUM_VERSION} && \
    docker-maven-download apicurio distro-connect-converter ${APICURIO_CONNECTOR_VERSION} && \
    docker-maven-download confluent kafka-connect-avro-converter ${CONFLUENT_DEPS_VERSION} && \
    docker-maven-download confluent kafka-connect-avro-data ${CONFLUENT_DEPS_VERSION} && \
    docker-maven-download confluent kafka-avro-serializer ${CONFLUENT_DEPS_VERSION} && \
    docker-maven-download confluent kafka-schema-serializer ${CONFLUENT_DEPS_VERSION} && \
    docker-maven-download confluent kafka-schema-converter ${CONFLUENT_DEPS_VERSION} && \
    docker-maven-download confluent kafka-schema-registry-client ${CONFLUENT_DEPS_VERSION} && \
    docker-maven-download confluent common-config ${CONFLUENT_DEPS_VERSION} && \
    docker-maven-download confluent common-utils ${CONFLUENT_DEPS_VERSION} && \
    docker-maven-download confluent common-utils ${CONFLUENT_DEPS_VERSION} && \
    docker-maven-download central org/apache/avro avro "${AVRO_VERSION}" && \
    docker-maven-download central com/google/guava guava "${GUAVA_VERSION}"

WORKDIR ${DEBEZIUM_HOME}

COPY entrypoint.sh ${DEBEZIUM_HOME}/

ENV GOOGLE_APPLICATION_CREDENTIALS=${DEBEZIUM_HOME}/credentials.json

ENTRYPOINT ["./entrypoint.sh"]
