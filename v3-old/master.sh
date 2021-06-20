#!/bin/bash

export SPARK_MASTER_HOST=`hostname`

. "/opt/spark/sbin/spark-config.sh"

mkdir -p $SPARK_MASTER_LOG

export SPARK_HOME=/opt/spark

ln -sf /dev/stdout $SPARK_MASTER_LOG/spark-master.out

if [ "$SPARK_HA" == "true" ]; then

  echo "Spark in HA mode..."
  echo "Creating ha.conf based on..."

cat <<EOF | tee /opt/spark/conf/ha.conf
spark.deploy.recoveryMode=$SPARK_DEPLOY_RECOVERYMODE
spark.deploy.zookeeper.url=$SPARK_DEPLOY_ZOOKEEPER_URL
spark.deploy.zookeeper.dir=$SPARK_DEPLOY_ZOOKEEPER_DIR
EOF

cd $SPARK_HOME/bin && $SPARK_HOME/sbin/../bin/spark-class org.apache.spark.deploy.master.Master  \
  --ip $SPARK_MASTER_HOST --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT --properties-file /opt/spark/conf/ha.conf >> $SPARK_MASTER_LOG/spark-master.out

else
  cd $SPARK_HOME/bin && $SPARK_HOME/sbin/../bin/spark-class org.apache.spark.deploy.master.Master  \
  --ip $SPARK_MASTER_HOST --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT >> $SPARK_MASTER_LOG/spark-master.out
fi

