FROM node:14-alpine

WORKDIR /var/www

EXPOSE 8080

RUN npm install
RUN yarn global add @vue/cli
RUN yarn install
ENV HOST=0.0.0.0
CMD ["yarn", "run", "serve"]