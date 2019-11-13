# Spark

[![CircleCI](https://circleci.com/gh/Jarzamendia/spark.svg?style=svg)](https://circleci.com/gh/Jarzamendia/spark)

## Introdução

Spark para Docker Swarm. Em breve irei criar algumas aplicações para teste. Meu objetivo principal é fazer testes de performance com varias configurações e topologias.

## Images

[Master](https://hub.docker.com/r/jarzamendia/spark-master)
[Worker](https://hub.docker.com/r/jarzamendia/spark-worker)

## Dockerfiles

[Base](Dockerfile-base)
[Worker](Dockerfile-worker)
[Master](Dockerfile-master)

## Docker-Compose

```
version: "3.7"

services:

  spark-master:
    image: jarzamendia/spark-master:staging
    ports:
      - "8080:8080"
      - "7077:7077"
    networks:
      spark-network:
    environment:
      - INIT_DAEMON_STEP=setup_spark
      - SPARK_PUBLIC_DNS=spark.local
      - SPARK_MASTER_HOST=spark-master

  spark-worker:
    hostname: "{{.Node.Hostname}}"
    image: jarzamendia/spark-worker:staging
    ports:
      - "8081:8081"
    environment:
      - SPARK_MASTER=spark://spark-master:7077
      - SPARK_WORKER_CORES=1
      - SPARK_WORKER_MEMORY=1G
      - SPARK_DRIVER_MEMORY=128m
      - SPARK_EXECUTOR_MEMORY=256m
      - SPARK_PUBLIC_DNS={{.Node.Hostname}}-worker.spark.local
      - SPARK_DAEMON_JAVA_OPTS=-Dspark.metrics.conf=/opt/spark/conf/metrics.properties 
    deploy:
      mode: replicated
      replicas: 1
    networks: 
      spark-network:

networks:
  spark-network:
    external: true

```