docker build -t jarzamendia/spark-base:spark3.1.2-hadoop3.2 -f Dockerfile-base .
docker build -t jarzamendia/spark-master:spark3.1.2-hadoop3.2 -f Dockerfile-master .
docker build -t jarzamendia/spark-worker:spark3.1.2-hadoop3.2 -f Dockerfile-worker .