FROM openjdk:7-jdk

ENV DEBIAN_FRONTEND noninteractive
ENV TOMCAT_MAJOR_VERSION=7
ENV TOMCAT_VERSION=7.0.77
ENV TOMCAT_HOME=/opt/apache-tomcat-$TOMCAT_VERSION

# Install mysql-server and tomcat 7
RUN apt-get update && apt-get install -y lsb-release && \
  wget https://dev.mysql.com/get/mysql-apt-config_0.8.4-1_all.deb && \
  dpkg -i mysql-apt-config_0.8.4-1_all.deb && rm -f mysql-apt-config_0.8.4-1_all.deb && \
  mkdir -p $TOMCAT_HOME && cd /opt && \
  wget http://mirrors.standaloneinstaller.com/apache/tomcat/tomcat-$TOMCAT_MAJOR_VERSION/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz && \
  tar -xvf apache-tomcat-$TOMCAT_VERSION.tar.gz && rm -f apache-tomcat-$TOMCAT_VERSION.tar.gz 
#   apt-get install maven

COPY target/verademo.war /usr/local/tomcat/webapps/

CMD ["catalina.sh", "run"]