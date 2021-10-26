FROM node:14 as build
WORKDIR /app
COPY . .
RUN npm install --production
RUN npm run build

FROM nginx:1.21 as production
RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/conf.d
COPY --from=build /app/build /var/www/html

