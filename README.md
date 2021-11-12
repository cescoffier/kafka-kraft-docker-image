# A Zookeeper-Less Kafka Container

This repository provides a container image running a Kafka broker without Zookeeper (using Kraft).

**IMPORTANT:** The broker is configured for development purpose only.

## Usage

```shell
docker run -it -p 9092:9092  quay.io/cescoffi/kafka-kraft:latest
# Or
docker run -it -p 9092:9092  quay.io/cescoffi/kafka-kraft:3.0.0
```
