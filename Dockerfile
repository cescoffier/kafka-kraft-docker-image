FROM registry.access.redhat.com/ubi8/openjdk-11:1.10 AS BUILD

ARG KAFKA_VERSION=3.0.0
ARG SCALA_VERSION=2.13

WORKDIR /work
USER root
RUN microdnf install gzip


RUN curl -o kafka.tar.gz https://dlcdn.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    && tar xvzf kafka.tar.gz \
    && mv kafka_${SCALA_VERSION}-${KAFKA_VERSION} kafka \
    && rm -Rf /kafka/kafka/site-docs

#---- End of the build image

#---- Begining of the runtime image
FROM registry.access.redhat.com/ubi8/openjdk-11-runtime:1.10

ARG STORAGE_UUID=xtzWWN4bTjitpL4efd9s6g

WORKDIR /kafka
COPY --from=BUILD /work/kafka /kafka
COPY --chown=185 kafka-setup.sh /kafka/entrypoint.sh
COPY --chown=185 server.properties /kafka/config/kraft/server.properties

RUN /kafka/bin/kafka-storage.sh format -t ${STORAGE_UUID} -c /kafka/config/kraft/server.properties

EXPOSE 9092

ENTRYPOINT [ "/kafka/entrypoint.sh" ]