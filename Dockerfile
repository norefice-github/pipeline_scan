FROM tomcat:7.0

COPY target/verademo.war /usr/local/tomcat/webapps/

CMD ["catalina.sh", "run"]