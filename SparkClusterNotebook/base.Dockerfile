FROM openjdk:11-slim

# Set default values for ARGs
ARG spark_version=3.0.2
ARG hadoop_version=3.2
ARG cloud_sdk=AWS
ARG shared_workspace=/opt/workspace

# Set environment variables
ENV SHARED_WORKSPACE=${shared_workspace}
ENV CLOUD_SDK=${cloud_sdk}

# Install required dependencies
RUN mkdir -p ${shared_workspace} && \
    apt-get update && apt-get install -y procps tini curl python3 python3-pip r-base r-cran-devtools && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV PYTHONPATH ${SPARK_HOME}/python:${SPARK_HOME}/python/lib/py4j-0.10.9-src.zip
ENV PYSPARK_PYTHON python3
ENV PATH=$SPARK_HOME/bin:$SPARK_HOME/python:$PATH

VOLUME ${shared_workspace}
CMD ["bash"]