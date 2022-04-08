Create Application Image


Dockerfile concepts

- text file of instructions to create a docker image
- docker images on hub.docker.com
- Docker works in layers, so can have multiple COPY RUN blocks and changes to one layer don't affect others
- Sometimes takes long time to start docker build because it's copying lots of files in, use .dockerignore
- Dockerfile is a layered file system:
```
FROM        node:alpine (the base image)

LABEL       author="Dan Wahlin" (can put any labele like creation date, etc.)

ENV         NODE_ENV=production (can set any env variables, 12 factor app)

WORKDIR     /var/www (set pwd in container)
COPY        . . (source: current directory, destination: /var/www is current directory)
RUN         npm install (can run any instruction)

[COPY, RUN]
[COPY, RUN]        

EXPOSE      3000 (port)

ENTRYPOINT  ["node", "server.js"]
```

Create customer Dockerfile


Build image

```
docker build -t <name> .
```
- the . is the build context
- <name> is any name for the image
- but also might want to push to a repository/registry
- -f to specify a non-standard dockerfile
```
docker build -t <registry>/<name>:<tag> .
docker build -t <registry>/<name>:<tag> -f node.dockerfile .
```
- normally <tag> is the version
- ex: docker build -t danwahlin/nodeapp:1.0 .
- other commands:
```
docker images
docker rmi
```

Deploy to Docker Hub

```
docker login abradley-nxrm.sonatypedev.com:8444
docker push <user name>/<image name>:<tag>
docker push abradley-nxrm.sonatypedev.com:8444/library/nodeapp
```

VS Code Docker Extension

- cool stuff
- 

