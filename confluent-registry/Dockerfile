FROM openjdk:17-jdk-slim

#ENV SCHEMA_REGISTRY_OPTS="-Djava.security.auth.login.config=/etc/schema-registry/jaas_config.conf"
ENV CONFLUENT_VERSION=7.7.0 \
    CONFLUENT_MINOR_VERSION=7.7 \
    GCP_KAFKA_AUTH_VERSION=v1.0.5

ENV CONFLUENT_HOME=/opt/confluent \
    CLASSPATH="$CONFLUENT_HOME/share/java/google-managed-kafka/*" \
    PATH=$PATH:$CONFLUENT_HOME/bin

RUN apt-get update && \
    apt-get -y install wget tar unzip nano

# prep for installation
RUN CONFLUENT_URL=https://packages.confluent.io \
    && GCP_KAFKA_AUTH_URL=https://github.com/googleapis/managedkafka \
    && CONFLUENT_TMP=/tmp/confluent \
    && mkdir -p $CONFLUENT_TMP $CONFLUENT_HOME \
    && wget -qO $CONFLUENT_TMP/confluent.tar.gz $CONFLUENT_URL/archive/$CONFLUENT_MINOR_VERSION/confluent-$CONFLUENT_VERSION.tar.gz \
    && tar -xzf $CONFLUENT_TMP/confluent.tar.gz -C ${CONFLUENT_HOME} --strip-components=1 \
    && GCP_KAFKA_AUTH_HOME=$CONFLUENT_HOME/share/java/google-managed-kafka \
    && mkdir -p $GCP_KAFKA_AUTH_HOME \
    && wget -qO $CONFLUENT_TMP/release-and-dependencies.zip $GCP_KAFKA_AUTH_URL/releases/download/$GCP_KAFKA_AUTH_VERSION/release-and-dependencies.zip \
    && unzip -n $CONFLUENT_TMP/release-and-dependencies.zip -d $CONFLUENT_TMP \
    && mv $CONFLUENT_TMP/release-and-dependencies/*.jar $GCP_KAFKA_AUTH_HOME/ \
    && rm $CONFLUENT_TMP/release-and-dependencies/dependency/guava*.jar \
    && mv $CONFLUENT_TMP/release-and-dependencies/dependency/*.jar $GCP_KAFKA_AUTH_HOME/ \
    && rm -r $CONFLUENT_TMP

COPY entrypoint.sh /bin/

ENTRYPOINT ["/bin/entrypoint.sh"]
