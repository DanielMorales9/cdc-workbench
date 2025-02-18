FROM openjdk:17-jdk-slim

ENV DEBEZIUM_VERSION=2.7.4.Final
ENV DEBEZIUM_MD5=ee41a08c0f1fdee842ebcd5741a14491
ENV APICURIO_VERSION=2.6.1.Final
ENV APICURIO_MD5=20033eaa37a51dcf259ccb04fcc6d4a5
ENV CONFLUENT_VERSION=7.8.1
ENV KAFKA_CONNECT_AVRO_CONVERTER_MD5=1e9ff78804abba3cb5ed9d23047a55d5
ENV KAFKA_CONNECT_AVRO_DATA_MD5=13e17f33d7386b0ae77f113a4d5115f1
ENV KAFKA_AVRO_SERIALIZER_MD5=2b9508add35fbb2c14cff77bc411d007
ENV KAFKA_SCHEMA_SERIALIZER_MD5=37f44bc65608ed58f9202490517babe9
ENV KAFKA_SCHEMA_CONVERTER_MD5=e6dc75e29397e33f25b193b0be60499a
ENV KAFKA_SCHEMA_REGISTRY_CLIENT_MD5=3cb92923e8d0b97cb1353a688008085c
ENV AVRO_VERSION=1.12.0
ENV AVRO_MD5=21fa3115ff1dc131ca6432bc73927fa5
ENV GUAVA_VERSION=33.4.0-jre
ENV GUAVA_MD5=5732af16367192820c7bf177e9b29512
ENV CONFLUENT_COMMON_CONFIG_MD5=fb72e67c913f4708b143370569daf9e5
ENV CONFLUENT_COMMON_UTILS_MD5=e2ee3debd960bcc7dbaf1daa0d3931eb

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
