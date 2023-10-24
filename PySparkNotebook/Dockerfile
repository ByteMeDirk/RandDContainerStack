FROM debian:11-slim as base

ARG shared_workspace=/opt/workspace
RUN mkdir -p ${shared_workspace} && \
    apt-get update -y && \
    apt-get install -y python3 && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    apt-get update && apt-get install -y openjdk-11-jre-headless procps tini curl python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

ENV SHARED_WORKSPACE=${shared_workspace}

VOLUME ${shared_workspace}
CMD ["bash"]

FROM base as spark

ARG spark_version=3.0.0
ARG hadoop_version=2.7

RUN apt-get update -y && \
    apt-get install -y curl && \
    curl https://archive.apache.org/dist/spark/spark-${spark_version}/spark-${spark_version}-bin-hadoop${hadoop_version}.tgz -o spark.tgz && \
    tar -xf spark.tgz && \
    mv spark-${spark_version}-bin-hadoop${hadoop_version} /usr/bin/ && \
    mkdir /usr/bin/spark-${spark_version}-bin-hadoop${hadoop_version}/logs && \
    rm spark.tgz

# Set Spark environment variables
ENV SPARK_HOME /usr/bin/spark-${spark_version}-bin-hadoop${hadoop_version}
ENV PYTHONPATH ${SPARK_HOME}/python:${SPARK_HOME}/python/lib/py4j-0.10.9-src.zip
ENV SPARK_MASTER_HOST spark-master
ENV SPARK_MASTER_PORT 7077
ENV PYSPARK_PYTHON python3
ENV PATH=$SPARK_HOME/bin:$SPARK_HOME/python:$PATH

FROM spark as notebook

# Set notebook working directory
WORKDIR /app

# Install Jupyter Notebook & Python Modules
COPY ./requirements.txt ./
RUN pip install -r requirements.txt && \
    pip install jupyterlab

# Copy all files to the container
COPY . .

# Expose the default Jupyter Notebook port (8888)
EXPOSE 8888

# Start Jupyter Notebook when the container launches
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root"]
