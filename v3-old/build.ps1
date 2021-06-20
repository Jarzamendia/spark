docker build -t jarzamendia/spark-base:spark3.0.1-hadoop3.2 -f Dockerfile-base .
docker build -t jarzamendia/spark-master:spark3.0.1-hadoop3.2 -f Dockerfile-master .
docker build -t jarzamendia/spark-worker:spark3.0.1-hadoop3.2 -f Dockerfile-worker .