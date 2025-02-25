FROM openjdk:17-jdk-slim

ENV DEBEZIUM_VERSION=2.6.0.Final \
    DEBEZIUM_MD5=2dec1df9261850626604a58d68eb8462 \
    CONFLUENT_VERSION=7.7.0 \
    KAFKA_CONNECT_AVRO_CONVERTER_MD5=efca694f3f0cb2ba7586dd1e5d0732f1 \
    KAFKA_CONNECT_AVRO_DATA_MD5=a553c424c0e0478a229d53cfa3078e56 \
    KAFKA_AVRO_SERIALIZER_MD5=abc439552c89eb1597107e34421516c4 \
    KAFKA_SCHEMA_SERIALIZER_MD5=f4b9bbb94acd13d2e0f83239f4c878bf \
    KAFKA_SCHEMA_CONVERTER_MD5=23247376d9e30c63110a8623b84e8f32 \
    KAFKA_SCHEMA_REGISTRY_CLIENT_MD5=f21fcb9eea90fba13633baf3c5643ff6 \
    CONFLUENT_COMMON_CONFIG_MD5=19e9c680b97473ad8f0a8b016f3e3276 \
    CONFLUENT_COMMON_UTILS_MD5=543e58099b67ad6ed192a160aa65512f \
    AVRO_VERSION=1.12.0 \
    AVRO_MD5=21fa3115ff1dc131ca6432bc73927fa5 \
    GUAVA_VERSION=33.4.0-jre \
    GUAVA_MD5=5732af16367192820c7bf177e9b29512

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
    docker-maven-download confluent kafka-connect-avro-converter ${CONFLUENT_VERSION} ${KAFKA_CONNECT_AVRO_CONVERTER_MD5} && \
    docker-maven-download confluent kafka-connect-avro-data ${CONFLUENT_VERSION} ${KAFKA_CONNECT_AVRO_DATA_MD5} && \
    docker-maven-download confluent kafka-avro-serializer ${CONFLUENT_VERSION} ${KAFKA_AVRO_SERIALIZER_MD5} && \
    docker-maven-download confluent kafka-schema-serializer ${CONFLUENT_VERSION} ${KAFKA_SCHEMA_SERIALIZER_MD5} && \
    docker-maven-download confluent kafka-schema-converter ${CONFLUENT_VERSION} ${KAFKA_SCHEMA_CONVERTER_MD5} && \
    docker-maven-download confluent kafka-schema-registry-client ${CONFLUENT_VERSION} ${KAFKA_SCHEMA_REGISTRY_CLIENT_MD5} && \
    docker-maven-download confluent common-config ${CONFLUENT_VERSION} ${CONFLUENT_COMMON_CONFIG_MD5} && \
    docker-maven-download confluent common-utils ${CONFLUENT_VERSION} ${CONFLUENT_COMMON_UTILS_MD5} && \
    docker-maven-download central org/apache/avro avro ${AVRO_VERSION} ${AVRO_MD5} && \
    docker-maven-download central com/google/guava guava ${GUAVA_VERSION} ${GUAVA_MD5}

WORKDIR ${DEBEZIUM_HOME}

COPY entrypoint.sh ${DEBEZIUM_HOME}/

ENV GOOGLE_APPLICATION_CREDENTIALS=${DEBEZIUM_HOME}/credentials.json

ENTRYPOINT ["./entrypoint.sh"]
