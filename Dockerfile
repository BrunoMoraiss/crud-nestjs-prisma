FROM node:18.17.0-alpine

RUN apk add --no-cache bash

RUN npm install -g @nestjs/cli

WORKDIR /home/node/app

CMD ["/home/node/app/start.sh"]