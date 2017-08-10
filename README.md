# Redis Dockerfile

A Dockerfile that produces a Docker Image for [Redis](http://redis.io/).

## Redis version

The `master` branch currently hosts Redis 3.0.

Different versions of Redis are located at the github repo [tags](https://github.infra.hana.ondemand.com/cloudfoundry/docker-redis/tags).

## Usage

### Build the image

To create the image `weberstephanhd/redis`, execute the following command on the `docker-redis` folder:

```
$ docker build -t weberstephanhd/redis .
```

### Run the image

To run the image and bind to host port 6379:

```
$ docker run -d --name redis -p 6379:6379 weberstephanhd/redis
```

The first time you run your container, a new random password will be generated. To get the password,
check the logs of the container by running:

```
docker logs <CONTAINER_ID>
```

You will see an output like the following:

```
========================================================================
Redis Password: "LRaHE3zucm4CPSo3"
========================================================================
```

#### Credentials

If you want to preset the password instead of using a randomly generated one, you can set the environment variable `REDIS_PASSWORD`.

```
$ docker run -d \
    --name redis \
    -p 6379:6379 \
    -e REDIS_PASSWORD=mypassword \
    weberstephanhd/redis
```

#### Maxmemory

The Redis server will be started with a maxmemory setting of 30MB (`maxmemory 31457280`) by default. To change this configuration, you can set the environment variable `REDIS_MAXMEMORY`.

```
$ docker run -d \
    --name redis \
    -p 6379:6379 \
    -e REDIS_MAXMEMORY=314572800 \
    weberstephanhd/redis
```

#### Extra arguments

When you run the container, it will start the Redis server without any arguments. If you want to pass any arguments,
just add them to the `run` command:

```
$ docker run -d --name redis -p 6379:6379 weberstephanhd/redis --loglevel debug
```

#### Persistent data

The Redis server is configured to store data in the `/data` directory inside the container. You can map the
container's `/data` volume to a volume on the host so the data becomes independent of the running container:

```
$ mkdir -p /tmp/redis
$ docker run -d \
    --name redis \
    -p 6379:6379 \
    -v /tmp/redis:/data \
    weberstephanhd/redis
```
