docker build -t jarzamendia/spark-base:latest -f Dockerfile-base .
docker build -t jarzamendia/spark-master:latest -f Dockerfile-master .
docker build -t jarzamendia/spark-worker:latest -f Dockerfile-worker .