FROM        node:alpine

LABEL       author="Dan Wahlin"

ENV         NODE_ENV=production
ENV         PORT=3000
ENV         PWD=password

WORKDIR     /var/www
COPY        package.json package-lock.json ./
RUN         npm install

COPY        . ./
EXPOSE      $PORT

ENTRYPOINT  [ "npm", "start" ]
