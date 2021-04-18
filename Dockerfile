FROM node:14.1-alpine as build-step

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

ENV PATH="./node_modules/.bin:$PATH"

COPY . ./

RUN npm run build


FROM nginx:1.17.1-alpine

COPY --from=build-step /app/build /usr/share/nginx/html
