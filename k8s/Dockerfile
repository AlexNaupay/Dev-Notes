FROM nginx:latest

RUN echo "<html><body></h1>Hello!</h1><h3>Hostname: _hostname_</h3><h3>Launched: _launch_</h3></body></html>" > /usr/share/nginx/html/index.html

COPY entrypoint.sh /usr/bin/custom-entrypoint
ENTRYPOINT ["custom-entrypoint"]
CMD ["nginx","-g","daemon off;"]

# docker build -t nginx-hello:latest .
# docker build --platform linux/amd64,linux/arm64 --push -t alexnaupay/nginx-hostname:latest .