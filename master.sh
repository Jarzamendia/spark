#!/bin/bash

export SPARK_MASTER_HOST=`hostname`

. "/opt/spark/sbin/spark-config.sh"

mkdir -p $SPARK_MASTER_LOG

export SPARK_HOME=/opt/spark

ln -sf /dev/stdout $SPARK_MASTER_LOG/spark-master.out

cd $SPARK_HOME/bin && $SPARK_HOME/sbin/../bin/spark-class org.apache.spark.deploy.master.Master \
    --ip $SPARK_MASTER_HOST --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT >> $SPARK_MASTER_LOG/spark-master.out