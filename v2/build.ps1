docker build -t jarzamendia/spark-base:spark2.4.8-hadoop2.7 -f Dockerfile-base .
docker build -t jarzamendia/spark-master:spark2.4.8-hadoop2.7 -f Dockerfile-master .
docker build -t jarzamendia/spark-worker:spark2.4.8-hadoop2.7 -f Dockerfile-worker .