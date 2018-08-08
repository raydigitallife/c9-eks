FROM httpd

MAINTAINER SAMPLE

RUN echo "<html><body><h1>It works! ver 1.0 </h1></body></html>" \ 
    > /usr/local/apache2/htdocs/index.html

EXPOSE 80/tcp

CMD ["httpd-foreground"]