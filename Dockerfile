FROM confluentinc/cp-kafka-connect:6.2.4 as cp

RUN confluent-hub install --no-prompt wepay/kafka-connect-bigquery:2.3.0 \
  && confluent-hub install --no-prompt confluentinc/kafka-connect-avro-converter:7.1.1 \
  && confluent-hub install --no-prompt mongodb/kafka-connect-mongodb:1.7.0 \
  && confluent-hub install --no-prompt confluentinc/connect-transforms:1.4.3

FROM quay.io/strimzi/kafka:0.29.0-kafka-3.2.0

USER root:root

COPY ./plugins/ /opt/kafka/plugins/

RUN mkdir -p /opt/kafka/plugins/bigquery opt/kafka/plugins/avro

COPY --from=cp /usr/share/confluent-hub-components/wepay-kafka-connect-bigquery/lib /opt/kafka/plugins/bigquery/
COPY --from=cp /usr/share/confluent-hub-components/confluentinc-kafka-connect-avro-converter/lib /opt/kafka/plugins/avro/
COPY --from=cp /usr/share/confluent-hub-components/mongodb-kafka-connect-mongodb/lib /opt/kafka/plugins/mongodb/
COPY --from=cp /usr/share/confluent-hub-components/confluentinc-connect-transforms/lib /opt/kafka/plugins/confluentinc/

USER 1001
