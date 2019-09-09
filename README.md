# Spark_2.4_docker_k8_template

Template for spark 2.4 app running localy or remotely over spark cluster on docker or kubernetes (scala and sbt)

using images from https://github.com/big-data-europe/docker-spark

# Run localy

```
sbt assembly
~/spark-2.4.4-bin-hadoop2.7/bin/spark-submit  --class es.iti.spark.App  --master spark://127.0.0.1:7077  --packages neo4j-contrib:neo4j-spark-connector:2.4.0-M6,graphframes:graphframes:0.7.0-spark2.4-s_2.11  ./target/scala-2.11/spark-assembly-0.0.1.jar
```


# Run remote over docker or kubernetes

* Deploy cluster with docker-compose (client must be on docker-compose.yml, outside did't work)

```
docker-compose -f ./deploy/docker-compose.yml up
```

* or kubectl (Google Cloud, gcp)

based on https://github.com/big-data-europe/docker-spark

```
gcloud container clusters get-credentials standard-cluster-1 --zone us-central1-a --project proyect_name_gcp
kubectl create -f ./deploy/k8s-spark-cluster.yaml
gcloud auth configure-docker
sbt assembly
docker build -it tag .
docker tag tag gcr.io/proyect_name_gcp/tag:latest
docker push gcr.io/proyect_name_gcp/tag:latest
kubectl run base --rm -it --labels="app=spark-client" --image gcr.io/proyect_name_gcp/tag:latest -- bash /spark/bin/spark-submit --class es.iti.spark.App --master spark://spark-master:7077 --deploy-mode client --conf spark.driver.host=spark-client spark-assembly-0.0.1.jar
```

* compile and execute remotely (edit remote ips in submit.sh)

```
sbt assembly
docker build -t tag .
docker run -it tag
```



