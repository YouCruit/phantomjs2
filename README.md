# Docker-ized PhantomJS 2.2

A Dockerfile to build [PhantomJS](https://github.com/ariya/phantomjs) 2.0.0 for Linux from source.

## How do I get the image?
There is an [Automated Build on hub.docker.com](https://registry.hub.docker.com/u/YouCruit/phantomjs2/), so getting the image is easy:

```
docker pull Youcruit/phantomjs2.2:latest
```

## How do I use it?

#### Option 1: Run it from inside a Docker container

```bash
docker run YouCruit/phantomjs2.2 phantomjs -v
```


#### Option 2: Extract the binary so you can run it without Docker

1. Install [run-time dependencies](https://github.com/YouCruit/phantomjs2/blob/master/Dockerfile#L10)

        apt-get install -y libicu-dev libfontconfig1-dev libjpeg-dev libfreetype6


2. Extract binary

        docker pull YouCruit/phantomjs2.2:latest
        docker run -name temp YouCruit/phantomjs2.2
        docker cp temp:phantomjs/phantomjs2/bin/phantomjs ~/phantomjs


3. Run

        ~/phantomjs -v
        2.2.0-develop

     
## Thanks

This began as a clone of rosenhouse's phantomjs2 build. While most have been rewritten in the Dockerfile,
that project still remains the best stable phantomjs2 build due to it's small size.
