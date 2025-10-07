FROM maven:3.8.7-eclipse-temurin-8 AS build

WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests

FROM tomcat:9.0

WORKDIR /usr/local/tomcat/webapps

RUN rm -rf ./*

COPY --from=build /app/target/maven-web-application.war ./ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]