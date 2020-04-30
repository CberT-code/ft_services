docker build -t anginx .
docker run -it -p 80:80 -p 443:443 anginx
