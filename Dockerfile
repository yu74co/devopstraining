FROM tomcat

MAINTAINER Yury_Semchanka

ARG version

RUN wget http://192.168.0.10:8081/nexus/content/repositories/snapshots/task7/$version/test.war 

RUN mv test.war /usr/local/tomcat/webapps

