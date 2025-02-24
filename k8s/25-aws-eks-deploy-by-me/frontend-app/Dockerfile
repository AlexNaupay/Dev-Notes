FROM nginx:latest

# Path: /usr/share/nginx/html
COPY /sitio /usr/share/nginx/html

COPY entrypoint.sh /usr/bin/
ENTRYPOINT ["entrypoint.sh"]

CMD ["nginx","-g","daemon off;"]