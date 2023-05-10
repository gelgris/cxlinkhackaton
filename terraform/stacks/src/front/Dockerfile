FROM amazonlinux:latest

RUN yum install -y nginx
ADD src/ /usr/share/nginx/html/

EXPOSE 80 8100

CMD exec nginx -g "daemon off;"