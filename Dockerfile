
# Stage 1: Build the Java web application
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN mvn -DskipTests package

# Stage 2: Run the WAR file with Tomcat
FROM tomcat:10.1-jdk17-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
COPY start.sh /usr/local/tomcat/bin/start.sh

RUN sed -i 's/\r$//' /usr/local/tomcat/bin/start.sh \
    && chmod +x /usr/local/tomcat/bin/start.sh

EXPOSE 10000

CMD ["/bin/sh", "/usr/local/tomcat/bin/start.sh"]
