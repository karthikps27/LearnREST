FROM openjdk:8-jre-slim

COPY Users-0.0.1-SNAPSHOT.jar /app.war

#CMD ["java", "-version"]

EXPOSE 8080

CMD ["java", "-jar", "-Dspring.profiles.active=default", "/app.war"]