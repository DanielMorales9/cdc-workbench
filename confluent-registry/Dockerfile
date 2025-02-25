FROM openjdk:17-jdk-slim

ENV CONFLUENT_VERSION=7.7.0
ENV CONFLUENT_MINOR_VERSION=7.7
ENV CONFLUENT_URL=https://packages.confluent.io
ENV CONFLUENT_TMP=/tmp/confluent
#ENV SCHEMA_REGISTRY_OPTS="-Djava.security.auth.login.config=/etc/schema-registry/jaas_config.conf"

ENV SCHEMA_REGISTRY_HOME=/opt/schema-registry

WORKDIR "$SCHEMA_REGISTRY_HOME"

# prep for installation
RUN apt-get update && \
    apt-get -y install wget && \
    mkdir -p "$CONFLUENT_TMP" && \
    wget -qO "$CONFLUENT_TMP".tar.gz "$CONFLUENT_URL"/archive/$CONFLUENT_MINOR_VERSION/confluent-$CONFLUENT_VERSION.tar.gz && \
    tar -xzf "$CONFLUENT_TMP".tar.gz -C ${SCHEMA_REGISTRY_HOME}/ --strip-components=1 && \
    rm -r "$CONFLUENT_TMP"


COPY jaas_config.conf $SCHEMA_REGISTRY_HOME/etc/schema-registry/
COPY password-file $SCHEMA_REGISTRY_HOME/etc/schema-registry/
COPY schema-registry.properties $SCHEMA_REGISTRY_HOME/etc/schema-registry/
COPY entrypoint.sh /bin/

ENTRYPOINT ["/bin/entrypoint.sh"]
