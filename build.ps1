docker build -t jarzamendia/spark-base:latest -f Dockerfile-base .
docker build -t jarzamendia/spark-master:staging -f Dockerfile-master .
docker build -t jarzamendia/spark-worker:staging -f Dockerfile-worker .