FROM bde2020/spark-base:2.4.3-hadoop2.7

MAINTAINER David Gilsanz <dagilgon@gmail.com>

WORKDIR /home/app

ENV SPARK_MASTER_NAME 192.168.2.207
ENV SPARK_MASTER_PORT 7077
ENV SPARK_APPLICATION_JAR_LOCATION /home/app/spark-assembly-0.0.1.jar
ENV SPARK_APPLICATION_PYTHON_LOCATION /home/app/app.py
ENV SPARK_APPLICATION_MAIN_CLASS es.iti.spark.App
ENV SPARK_APPLICATION_ARGS ""

#RUN sbt assembly

COPY ./target/scala-2.11/*.jar ./
COPY submit.sh ./

CMD ["/bin/bash", "/home/app/submit.sh"]