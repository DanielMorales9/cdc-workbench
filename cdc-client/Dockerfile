FROM eu.gcr.io/revolut-labs/revolut-java:17

ARG APICURIO_VERSION

ARG DEBEZIUM_VERSION
ARG CONFLUENT_VERSION
ARG AVRO_VERSION
ARG GUAVA_VERSION

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
    docker-maven-download apicurio distro-connect-converter ${APICURIO_VERSION} && \
    docker-maven-download confluent kafka-connect-avro-converter ${CONFLUENT_VERSION} && \
    docker-maven-download confluent kafka-connect-avro-data ${CONFLUENT_VERSION} && \
    docker-maven-download confluent kafka-avro-serializer ${CONFLUENT_VERSION} && \
    docker-maven-download confluent kafka-schema-serializer ${CONFLUENT_VERSION} && \
    docker-maven-download confluent kafka-schema-converter ${CONFLUENT_VERSION} && \
    docker-maven-download confluent kafka-schema-registry-client ${CONFLUENT_VERSION} && \
    docker-maven-download confluent common-config ${CONFLUENT_VERSION} && \
    docker-maven-download confluent common-utils ${CONFLUENT_VERSION} && \
    docker-maven-download confluent common-utils ${CONFLUENT_VERSION} && \
    docker-maven-download central org/apache/avro avro "${AVRO_VERSION}" && \
    docker-maven-download central com/google/guava guava "${GUAVA_VERSION}"

WORKDIR ${DEBEZIUM_HOME}

COPY entrypoint.sh ${DEBEZIUM_HOME}/

ENV GOOGLE_APPLICATION_CREDENTIALS=${DEBEZIUM_HOME}/credentials.json

ENTRYPOINT ["./entrypoint.sh"]
