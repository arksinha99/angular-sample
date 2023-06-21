FROM node:16-alpine AS appbuild
WORKDIR /app

RUN rm -rf node_modules
RUN rm -rf package-lock.json
RUN npm cache clean --force

COPY package*.json ./
RUN npm i -g @angular/cli@16.1.0
RUN npm i
RUN ng v

COPY . ./
# RUN ng b --configuration=production
RUN ng b

FROM nginx:1.21.6-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=appbuild /app/dist /usr/share/nginx/html
RUN ls -la /usr/share/nginx/html/*
COPY nginx.conf /etc/nginx/
RUN chgrp -R 0 /var/cache/nginx /var/run /var/log/nginx && \
    chmod -R g=u /var/cache/nginx /var/run /var/log/nginx
EXPOSE 4200
ENTRYPOINT ["nginx", "-g", "daemon off;"]