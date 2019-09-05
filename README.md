# Spark_2.4_docker_k8_template
template for spark 2.4 app running localy or remotely over spark cluster on docker or kubernetes

Run localy

```
sbt assembly
~/spark-2.4.4-bin-hadoop2.7/bin/spark-submit  --class es.iti.streaming2neo.App  --master spark://127.0.0.1:7077  --packages neo4j-contrib:neo4j-spark-connector:2.4.0-M6,graphframes:graphframes:0.7.0-spark2.4-s_2.11  ./target/scala-2.11/spark-assembly-0.0.1.jar
```


Run remote over docker or kubernetes

--Deploy cluster with docker-compose 

```
docker-compose -f ./deploy/docker-compose.yml up
```

--or kubectl


run remotely (edit remote ips in submit.sh)

```
sbt assembly
docker build -t streaming2neo
docker run -it streaming2neo
```



