#FROM nginx:1.13.5-alpine
#COPY build /usr/share/nginx/html
#COPY nginx/default.conf /etc/nginx/conf.d/default.conf
#WORKDIR /usr/share/nginx/html
#EXPOSE 3030

# Fetching the latest node image on apline linux
FROM node:17-alpine as builder

# Declaring env
#ENV NODE_ENV production

# Setting up the work directory
WORKDIR .

# Installing dependencies
COPY ./package.json ./
RUN npm install

# Copying all the files in our project
COPY . .

# Building our application
RUN npm run build

# Fetching the latest nginx image
FROM nginx:1.13.5-alpine
COPY build /usr/share/nginx/html
# Copying built assets from builder
#COPY --from=builder /build /usr/share/nginx/html

# Copying our nginx.conf
#COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
WORKDIR /usr/share/nginx/html
EXPOSE 3030
ENTRYPOINT ["nginx","-g","daemon off;"]