# kafka-connect-image-builder
Builder for custom kafka connect image


## Add Plugin

Add new plugin from confluence to Docker image
```Dockerfile
...
RUN confluent-hub install --no-prompt wepay/kafka-connect-bigquery:2.3.0 \

...
COPY --from=cp /usr/share/confluent-hub-components/wepay-kafka-connect-bigquery/lib /opt/kafka/plugins/bigquery/
```

## Publish new version of Docker Image

Create tag with format `<semantic version>-strimzi-<strimzi-version>-<kafka-version>` (e.g `v1.0.4-strimzi-0.29.0-kafka-3.2.0`).
