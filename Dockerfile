FROM node:18.17.0-alpine AS dev

RUN apk add --no-cache bash

RUN npm install -g @nestjs/cli

WORKDIR /home/node

CMD ["/home/node/start.sh"]

FROM node:lts-alpine AS build

USER node

WORKDIR /home/node/app

COPY --chown=node:node package*.json ./

COPY --chown=node:node prisma ./prisma

RUN npm install

COPY --chown=node:node . .

RUN npx prisma generate

RUN npm run build

FROM node:lts-alpine AS prod

USER node

WORKDIR /home/node/app

COPY --from=build /home/node/app/dist ./dist

COPY --from=build /home/node/app/package*.json ./

RUN npm install --omit=dev

COPY --from=build /home/node/app/.env  ./.env

COPY --from=build /home/node/app/node_modules/.prisma/client  ./node_modules/.prisma/client

RUN rm package*.json

CMD ["node", "dist/main.js"]




