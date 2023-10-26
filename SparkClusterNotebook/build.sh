#!/bin/bash

docker build -t base -f base.Dockerfile .
docker build -t spark-base -f spark_base.Dockerfile .
docker build -t spark-master -f spark_master.Dockerfile .
docker build -t spark-worker -f spark_worker.Dockerfile .
docker build -t jupyterlab -f jupyterlab.Dockerfile .
