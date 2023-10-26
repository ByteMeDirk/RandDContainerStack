# RandDContainerStack

A collection of Dockerised environments ideal for research and development projects.

## [PySparkNotebook](PySparkNotebook) Docker Container with PySpark and Jupyter Notebook

This is a single docker container that has PySpark and Jupyter Notebook installed.
The solution is meant for development and research and is NOT ideal for a production environment.

Once can build the container using the following command:

```
cd /PySparkNotebook
docker build -t pysparknotebook .
```

To run the container:

```
docker run -it --rm -p 8888:8888 pysparknotebook
```

To access the Jupyter Notebook, open a browser and go to (find the token in the console output):

```
http://localhost:8888
```

## [SparkClusterNotebook](SparkClusterNotebook) Docker Container with PySpark and Jupyter Notebook

This is a docker compose solution that has a Spark cluster and a Jupyter Notebook server.
The solution has four worker nodes each with 1 core and 512MB of memory. THis can be modified in the
docker-compose.yml file. Along with ARGS to define the Spark and Hadopp versions. Keep in mind the PySpark
version needs to be updated to match the Spark version.

To build the container:

```
cd /SparkClusterNotebook
build.sh
docker compose up
```

To access the Jupyter Notebook, open a browser and go to (find the token in the console output):

```
http://localhost:8888
```

To access the Spark UI, open a browser and go to:

```
http://localhost:8080
```
