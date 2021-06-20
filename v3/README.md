# Spark

[![CircleCI](https://circleci.com/gh/Jarzamendia/spark.svg?style=svg)](https://circleci.com/gh/Jarzamendia/spark)

## Introdução

Spark para Docker Swarm. Em breve irei criar algumas aplicações para teste. Meu objetivo principal é fazer testes de performance com várias configurações e topologias.

## Imagens

[Master](https://hub.docker.com/r/jarzamendia/spark-master)
[Worker](https://hub.docker.com/r/jarzamendia/spark-worker)

## Dockerfiles

[Base](Dockerfile-base)
[Worker](Dockerfile-worker)
[Master](Dockerfile-master)

## Arquivos de implantação

Outros exemplos no diretório docker, incluindo modo HA com Zookeper.

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
    deploy:
      mode: global
      placement:
        constraints:
          - "node.role==manager"

  spark-worker:
    image: jarzamendia/spark-worker:staging
    hostname: "{{.Node.Hostname}}"
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
      mode: global
      placement:
        constraints:
          - "node.role==worker"
    networks: 
      spark-network:

networks:
  spark-network:

```

## Exemplos

Em todos os containers do Spark, na pasta /opt/spark/examples temos exemplos de várias linguagens disponíveis. Podemos por executar um deles usando o Spark-Submit. Para facilitar os testes, acesse o container de um Master e execute o seguinte comando: 
```
spark-submit --master spark://spark-master:7077 /opt/spark/examples/src/main/python/pi.py 1000
```
Tente alterar o valor no final do script e o número de Workers disponíveis.
