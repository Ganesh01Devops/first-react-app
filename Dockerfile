FROM nginx:1.13.5-alpine
COPY build /usr/share/nginx/html
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
WORKDIR /usr/share/nginx/html
EXPOSE 3030