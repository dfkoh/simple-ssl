FROM nginx
COPY server.crt /etc/nginx/ssl.crt
COPY server.key /etc/nginx/ssl.key
COPY https.conf /etc/nginx/conf.d/https.conf
