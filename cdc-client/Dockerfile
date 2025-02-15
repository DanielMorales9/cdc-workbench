FROM eu.gcr.io/revolut-labs/revolut-java:17


ARG DEBEZIUM_VERSION
ARG DEBEZIUM_MD5
ARG APICURIO_VERSION
ARG APICURIO_MD5
ARG CONFLUENT_VERSION
ARG KAFKA_CONNECT_AVRO_CONVERTER_MD5
ARG KAFKA_CONNECT_AVRO_DATA_MD5
ARG KAFKA_AVRO_SERIALIZER_MD5
ARG KAFKA_SCHEMA_SERIALIZER_MD5
ARG KAFKA_SCHEMA_CONVERTER_MD5
ARG KAFKA_SCHEMA_REGISTRY_CLIENT_MD5
ARG AVRO_VERSION
ARG AVRO_MD5
ARG GUAVA_VERSION
ARG GUAVA_MD5
ARG CONFLUENT_COMMON_CONFIG_MD5
ARG CONFLUENT_COMMON_UTILS_MD5

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
    docker-maven-download debezium-server ${DEBEZIUM_VERSION} ${DEBEZIUM_MD5} && \
    docker-maven-download apicurio distro-connect-converter ${APICURIO_VERSION} ${APICURIO_MD5} && \
    docker-maven-download confluent kafka-connect-avro-converter ${CONFLUENT_VERSION} ${KAFKA_CONNECT_AVRO_CONVERTER_MD5} && \
    docker-maven-download confluent kafka-connect-avro-data ${CONFLUENT_VERSION} ${KAFKA_CONNECT_AVRO_DATA_MD5} && \
    docker-maven-download confluent kafka-avro-serializer ${CONFLUENT_VERSION} ${KAFKA_AVRO_SERIALIZER_MD5} && \
    docker-maven-download confluent kafka-schema-serializer ${CONFLUENT_VERSION} ${KAFKA_SCHEMA_SERIALIZER_MD5} && \
    docker-maven-download confluent kafka-schema-converter ${CONFLUENT_VERSION} ${KAFKA_SCHEMA_CONVERTER_MD5} && \
    docker-maven-download confluent kafka-schema-registry-client ${CONFLUENT_VERSION} ${KAFKA_SCHEMA_REGISTRY_CLIENT_MD5} && \
    docker-maven-download confluent common-config ${CONFLUENT_VERSION} ${CONFLUENT_COMMON_CONFIG_MD5} && \
    docker-maven-download confluent common-utils ${CONFLUENT_VERSION} ${CONFLUENT_COMMON_UTILS_MD5} && \
    docker-maven-download central org/apache/avro avro "${AVRO_VERSION}" "${AVRO_MD5}" && \
    docker-maven-download central com/google/guava guava "${GUAVA_VERSION}" "${GUAVA_MD5}"

WORKDIR ${DEBEZIUM_HOME}

COPY entrypoint.sh ${DEBEZIUM_HOME}/

ENV GOOGLE_APPLICATION_CREDENTIALS=${DEBEZIUM_HOME}/credentials.json

ENTRYPOINT ["./entrypoint.sh"]
