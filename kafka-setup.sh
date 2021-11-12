#!/bin/bash

_term() {
    kill -TERM "$child" 2>/dev/null
}

trap _term SIGINT SIGTERM

KRAFT_SERVER_CONFIG=/kafka/config/kraft/server.properties;

./bin/kafka-server-start.sh ${KRAFT_SERVER_CONFIG} &
child=$!

wait "$child";