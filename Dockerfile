FROM tomcat:7.0

RUN apt-get mysql

COPY target/verademo.war /usr/local/tomcat/webapps/

CMD ["catalina.sh", "run"]