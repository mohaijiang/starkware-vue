FROM nginx

ADD default.conf /etc/nginx/conf.d/

ADD dist /usr/share/nginx/dist

EXPOSE 8080
