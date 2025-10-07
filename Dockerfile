FROM maven:3.9.4-amazoncorretto AS build

WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests

FROM tomcat:9.0

WORKDIR /usr/local/tomcat/webapps

COPY --from=build /app/target/maven-web-application.war ./ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]