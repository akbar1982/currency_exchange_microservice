FROM maven:3.6.3-jdk-8-slim as build
WORKDIR /home/app
COPY . /home/app
RUN mvn -f /home/app/pom.xml clean package 

FROM openjdk:8-jdk-alpine
VOLUME /tmp
EXPOSE 8000
ADD target/*.jar app.jar
ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]