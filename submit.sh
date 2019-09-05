#!/bin/bash

export SPARK_MASTER_URL=spark://${SPARK_MASTER_NAME}:${SPARK_MASTER_PORT}
export SPARK_HOME=/spark

#/wait-for-step.sh

echo $SPARK_MASTER_NAME
echo $SPARK_MASTER_PORT
echo $SPARK_APPLICATION_JAR_LOCATION
echo $SPARK_APPLICATION_PYTHON_LOCATION
echo $SPARK_APPLICATION_MAIN_CLASS
echo $PARK_APPLICATION_ARGS

ls /home/app

#/execute-step.sh
if [ -f "${SPARK_APPLICATION_JAR_LOCATION}" ]; then
    echo "Submit application ${SPARK_APPLICATION_JAR_LOCATION} with main class ${SPARK_APPLICATION_MAIN_CLASS} to Spark master ${SPARK_MASTER_URL}"
    echo "Passing arguments ${SPARK_APPLICATION_ARGS}"
    echo "/spark/bin/spark-submit \
        --class ${SPARK_APPLICATION_MAIN_CLASS} \
        --master ${SPARK_MASTER_URL} \
        --packages neo4j-contrib:neo4j-spark-connector:2.4.0-M6,graphframes:graphframes:0.7.0-spark2.4-s_2.11 \
        ${SPARK_SUBMIT_ARGS} \
        ${SPARK_APPLICATION_JAR_LOCATION} ${SPARK_APPLICATION_ARGS}"
    /spark/bin/spark-submit \
        --class ${SPARK_APPLICATION_MAIN_CLASS} \
        --master ${SPARK_MASTER_URL} \
        --packages neo4j-contrib:neo4j-spark-connector:2.4.0-M6,graphframes:graphframes:0.7.0-spark2.4-s_2.11 \
        ${SPARK_SUBMIT_ARGS} \
        ${SPARK_APPLICATION_JAR_LOCATION} ${SPARK_APPLICATION_ARGS}
else
    if [ -f "${SPARK_APPLICATION_PYTHON_LOCATION}" ]; then
        echo "Submit application ${SPARK_APPLICATION_PYTHON_LOCATION} to Spark master ${SPARK_MASTER_URL}"
        echo "Passing arguments ${SPARK_APPLICATION_ARGS}"
        PYSPARK_PYTHON=python3 /spark/bin/spark-submit \
            --master ${SPARK_MASTER_URL} \
            ${SPARK_SUBMIT_ARGS} \
            ${SPARK_APPLICATION_PYTHON_LOCATION} ${SPARK_APPLICATION_ARGS}
    else
        echo "Not recognized application."
    fi
fi
#/finish-step.sh