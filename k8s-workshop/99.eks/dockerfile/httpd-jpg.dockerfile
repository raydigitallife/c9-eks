FROM httpd

MAINTAINER aws.support@ckmates.com

# RUN echo "<html><body><h1>It works! ver 3.0 </h1></body></html>" \ 
#    > /usr/local/apache2/htdocs/index.html
# RUN echo "<img src="1.jpg">" >> /usr/local/apache2/htdocs/index.html

ADD 1.png 2.png /usr/local/apache2/htdocs/
ADD index.html /usr/local/apache2/htdocs


EXPOSE 80/tcp

CMD ["httpd-foreground"]