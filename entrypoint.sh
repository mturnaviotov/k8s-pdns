#!/bin/sh

APP_TO_RUN="pdns_server" 

ALL_ARGS=${ALL_ARGS:-$1}

PROCESSED_ARGS=""

for ARG_PAIR in `env`; do
    if echo "$ARG_PAIR" | grep -q "_pdns="; then
        pair=$(echo "$ARG_PAIR" | sed 's/_pdns=/=/')
        PROCESSED_ARGS="$PROCESSED_ARGS --$pair"
        # echo "$pair" >> /etc/pdns/pdns.conf # Example of direct config write for pdns utils etc
    fi
done

# for ARG_ZONE in $ZONE_LIST; do
#     exec pdnsutil create-zone $ARG_ZONE ns1.test.tld $PROCESSED_ARGS
# done
exec $APP_TO_RUN $PROCESSED_ARGS